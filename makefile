all:
	stow --verbose --target=$(HOME) --restow $(shell ls -d */)

simulate_all:
	stow --verbose --target=$(HOME) --simulate --restow $(shell ls -d */)

delete:
	stow --verbose --target=$(HOME) --delete $(shell ls -d */)
