$200output = "$PSScriptRoot\bin\200.m3u"
$404output = "$PSScriptRoot\bin\404.m3u"

$index = 001

while($index -le 999){
    $indexString = $index.ToString().PadLeft(3,"0");
    $urlRoot = "http://61.58.60.230:9000/live/$indexString.m3u8"
    try{
        $response = invoke-webrequest $urlRoot -DisableKeepAlive -UseBasicParsing 
        if($response.StatusCode -eq 200){
            echo "[200]" $urlRoot 
            Add-Content $200output -Value $urlRoot
        }else{
            echo "[UNK]" $urlRoot 
            Add-Content $404output -Value $urlRoot
        }
    }catch{
        echo "[400]" $urlRoot 
        Add-Content $404output -Value $urlRoot
    }
    $index++
}