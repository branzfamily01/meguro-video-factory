# Windowsへの導入

PowerShellで次を実行します。

```powershell
New-Item -ItemType Directory -Force "$HOME\.agents\skills" | Out-Null
Copy-Item -Recurse -Force ".\video-everything" "$HOME\.agents\skills\video-everything"
```

その後、Codexを再起動し、`/skills`で確認します。

使用例：

```text
$video-everything を使って、この画像とQRコードから15秒の縦型学校見学会告知動画を作って。1080×1920、BGMなし、プレビューを先に見せて。
```
