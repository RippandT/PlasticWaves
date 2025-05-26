extends Node
class_name Math

# Decimal places
const DECIMALS = {
	"HUNDREDTHS": 100,
	"THOUSANDTHS": 1000,
	"TENTHOUSANDTHS": 10000
}

## Round up number to the nearest place in decimal
## place is formatted by a whole number (100 for hundredths)
static func roundup(value: float, place: float = 100) -> float:
	return round(value * place) / place
