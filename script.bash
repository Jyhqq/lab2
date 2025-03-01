if [ $# -ne 2 ]; then
    echo "Usage: $0 <number1> <number2>"
    exit 1
fi

x=$1
y=$2

if ! [[ "$x" =~ ^-?[0-9]+$ ]] || ! [[ "$y" =~ ^-?[0-9]+$ ]]; then
    echo "Error: Both arguments must be integers."
    exit 1
fi

sum=$((x + y))
difference=$((x - y))
product=$((x * y))

echo "$sum $difference $product"