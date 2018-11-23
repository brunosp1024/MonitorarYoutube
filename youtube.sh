#!/usr/bin/env bash

#author: Keila e Bruno <keila.luk.8@gmail.com><brunosalvador145@gmail.com>
#describe: Get data yotube video and channel details
#version: 0.1
#license: MIT License

function youtube(){

    echo "Teste do script"

    local _video=$(mktemp)
    local _channel=$(mktemp)
    local _url="https://youtube.com/channel"

    wget "$1" -O "$_video" 2>/dev/null

    local _title=$(grep '<title>' "$_video" | sed 's/<[^>]*>//g' | sed 's/ - You.*//g')

    local _publi=$(grep 'Publicado.*<\/strong>' "$_video" | sed 's/.*Publicado/Publicado/g ; s/<\/strong>.*//g' | sed 's/Publicado em //g')

    local _views=$(grep 'watch-view-count' "$_video" | sed 's/<[^>]*>//g' | sed 's/ visualizações//g')

    local _id=$(sed 's/channel/\n&/g' "$_video" | grep '^channel' |sed -n 1p | sed 's/isCrawlable.*//g;s/..,.*//g;s/.*"//g')

    wget "$_url/$_id" -O "$_channel" 2>/dev/null

    local _tchannel=$(sed -n '/title/{p; q;}' "$_channel" | sed 's/<title>  //g')
    
    echo "Titulo do canal: $_tchannel"
    echo "Titulo do video: $_title"
    echo "Visualizações: $_views"
    echo "Data de publicação: $_publi"
    echo "Link do vídeo: $_url/$_id"

}

youtube "$1"
