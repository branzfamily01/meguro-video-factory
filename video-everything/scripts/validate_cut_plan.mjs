#!/usr/bin/env node

import fs from "node:fs";
import path from "node:path";

function fail(message) {
  process.stderr.write(`ERROR: ${message}\n`);
  process.exit(2);
}

const planPath = process.argv[2];
if (!planPath) {
  fail("Usage: validate_cut_plan.mjs <cut-plan.json>");
}

let plan;
try {
  plan = JSON.parse(fs.readFileSync(planPath, "utf8"));
} catch (error) {
  fail(`Cannot read valid JSON from ${planPath}: ${error.message}`);
}

const errors = [];
const warnings = [];
const target = Number(plan.targetDuration);
const fps = Number(plan.fps ?? 30);
const toleranceFrames = Number(plan.toleranceFrames ?? 1);
const nonSourceDuration = Number(plan.nonSourceDuration ?? 0);
const segments = Array.isArray(plan.segments) ? plan.segments : [];

if (!Number.isFinite(target) || target <= 0) {
  errors.push("targetDuration must be a positive number");
}
if (!Number.isFinite(fps) || fps <= 0) {
  errors.push("fps must be a positive number");
}
if (!Number.isFinite(toleranceFrames) || toleranceFrames < 0) {
  errors.push("toleranceFrames must be zero or greater");
}
if (!Number.isFinite(nonSourceDuration) || nonSourceDuration < 0) {
  errors.push("nonSourceDuration must be zero or greater");
}
if (segments.length === 0) {
  errors.push("segments must contain at least one item");
}

const planDir = path.dirname(path.resolve(planPath));
const normalized = [];
let sourceDuration = 0;

for (const [index, segment] of segments.entries()) {
  const id = String(segment.id ?? `segment-${index + 1}`);
  const source = String(segment.source ?? "");
  const start = Number(segment.start);
  const end = Number(segment.end);
  const speed = Number(segment.speed ?? 1);

  if (!source) {
    errors.push(`${id}: source is required`);
  }
  if (!Number.isFinite(start) || start < 0) {
    errors.push(`${id}: start must be zero or greater`);
  }
  if (!Number.isFinite(end) || end <= start) {
    errors.push(`${id}: end must be greater than start`);
  }
  if (!Number.isFinite(speed) || speed <= 0) {
    errors.push(`${id}: speed must be greater than zero`);
  }

  if (
    source &&
    !/^[a-z][a-z0-9+.-]*:\/\//i.test(source) &&
    !fs.existsSync(path.resolve(planDir, source))
  ) {
    warnings.push(`${id}: source path does not exist relative to plan: ${source}`);
  }

  if (
    Number.isFinite(start) &&
    Number.isFinite(end) &&
    end > start &&
    Number.isFinite(speed) &&
    speed > 0
  ) {
    const outputDuration = (end - start) / speed;
    sourceDuration += outputDuration;
    normalized.push({
      id,
      source,
      start,
      end,
      speed,
      outputDuration,
      allowOverlap: segment.allowOverlap === true,
    });
  }
}

const bySource = new Map();
for (const segment of normalized) {
  if (!bySource.has(segment.source)) bySource.set(segment.source, []);
  bySource.get(segment.source).push(segment);
}

for (const [source, sourceSegments] of bySource.entries()) {
  const sorted = [...sourceSegments].sort((a, b) => a.start - b.start);
  for (let index = 1; index < sorted.length; index += 1) {
    const previous = sorted[index - 1];
    const current = sorted[index];
    const overlap = previous.end - current.start;
    const frameDuration = Number.isFinite(fps) && fps > 0 ? 1 / fps : 0;
    if (
      overlap > frameDuration &&
      !previous.allowOverlap &&
      !current.allowOverlap
    ) {
      errors.push(
        `${source}: ${previous.id} and ${current.id} overlap by ${overlap.toFixed(3)}s; set allowOverlap only when intentional`,
      );
    }
  }
}

const total = sourceDuration + nonSourceDuration;
const tolerance =
  Number.isFinite(fps) && fps > 0 && Number.isFinite(toleranceFrames)
    ? toleranceFrames / fps
    : 0;
const delta = Number.isFinite(target) ? total - target : Number.NaN;

process.stdout.write("Cut plan\n");
process.stdout.write(`  Segments: ${normalized.length}\n`);
for (const segment of normalized) {
  process.stdout.write(
    `  - ${segment.id}: ${segment.start.toFixed(3)}–${segment.end.toFixed(3)}s / ${segment.speed}x = ${segment.outputDuration.toFixed(3)}s\n`,
  );
}
process.stdout.write(`  Source duration: ${sourceDuration.toFixed(3)}s\n`);
process.stdout.write(`  Non-source duration: ${nonSourceDuration.toFixed(3)}s\n`);
process.stdout.write(`  Total: ${total.toFixed(3)}s\n`);
if (Number.isFinite(target)) {
  process.stdout.write(
    `  Target: ${target.toFixed(3)}s; delta ${delta >= 0 ? "+" : ""}${delta.toFixed(3)}s; tolerance ±${tolerance.toFixed(3)}s\n`,
  );
  if (Math.abs(delta) > tolerance) {
    errors.push(
      `total duration differs from target by ${Math.abs(delta).toFixed(3)}s`,
    );
  }
}

for (const warning of warnings) {
  process.stderr.write(`WARNING: ${warning}\n`);
}
if (errors.length > 0) {
  for (const error of errors) {
    process.stderr.write(`ERROR: ${error}\n`);
  }
  process.exit(1);
}

process.stdout.write("PASS: cut plan is structurally valid and within duration tolerance\n");
