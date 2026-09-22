PYTHON ?= python3

.PHONY: all extract build check verify audit-release clean bootstrap

all: check

extract:
	$(PYTHON) tools/extract_rom.py --rom "$(ROM)"

build:
	$(PYTHON) tools/build.py

check: build
	$(PYTHON) tools/verify.py

verify: build
	$(PYTHON) tools/verify.py --reference "$(ROM)"

audit-release:
	$(PYTHON) tools/audit_release.py

bootstrap:
	$(PYTHON) tools/build.py --bootstrap

clean:
	$(PYTHON) -c 'import shutil; shutil.rmtree("build", ignore_errors=True); shutil.rmtree("generated", ignore_errors=True)'
