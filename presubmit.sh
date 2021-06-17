#!/bin/bash
source ./venv/bin/activate
FILES=`find . -type f -name "*.py" -not -path "./venv/*" -not -path "./resource_lists/*"`
flake8 --ignore=E501,E266,W503 $FILES
mypy --strict $FILES



# Run Unit Tests
coverage run -m unittest discover -s . -p '*_test.py'

# A bad attempt at integration tests by running the calculator builder over
# everything. This will need to be changed in the future but is fine as an
# interim solution.
mv output output.bak
coverage run -a build.py
coverage run -a build.py --force-html
coverage run -a build.py
rm -r output/
mv output.bak output

coverage report -m --omit='venv/*'