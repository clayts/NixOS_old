if [ $# -eq 0 ]
then
	echo "Run this on new hardware to generate the file ./hosts/<name>.nix with an auto-detected hardware configuration"
	echo "Usage: capture-hardware.sh <name>"
	exit
fi

cd $(dirname "$0") &&
nixos-generate-config --show-hardware-config > "./hardware/$1.nix"