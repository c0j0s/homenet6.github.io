$input = "$PSScriptRoot\livelist.m3u"
Get-Content $input | Where-Object {$_ -match "^http*"} | ForEach-Object {
    try{
        $response = invoke-webrequest $_ -DisableKeepAlive 
        if($response.StatusCode -eq 200){
            echo "[200 LIVE] $_"
        }else{
            echo "[UNK DOWN] $_"
        }
    }catch{
        echo "[404 DOWN] $_"
    }
}