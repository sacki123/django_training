@echo off

call .\cbin\config.cmd
python setup.py sdist --format=zip
