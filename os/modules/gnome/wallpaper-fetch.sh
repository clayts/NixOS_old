if [ $# -eq 0 ]
then
	echo "Download a random wallpaper from github.com/clayts/Wallpapers"
	echo "Usage: wallpaper-fetch <file>"
	exit
fi

echo "Fetching index"
baseURL="https://raw.githubusercontent.com/clayts/Wallpapers/master"
indexPath="index.txt"
index=($(curl -s "$baseURL/$indexPath"))
echo "Index contains ${#index[@]} images"
path="$(printf "%s\n" "${index[@]}" | shuf -n1)"
if [ "$path" = "" ]
then
    echo "Failed"
    exit 1
fi
echo "Fetching $path"
temp=$(mktemp) &&
(
    curl -s "$baseURL/$path" > $temp &&
    mv $temp "$1" && echo "Wrote $1"
) || (
    rm $temp && echo "Failed" && exit 1
)