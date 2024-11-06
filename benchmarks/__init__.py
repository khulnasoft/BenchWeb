import importlib
import re
from glob import glob

test_types = {}
test_type_folders = glob("/BenchWeb/benchmarks/*/")

# Loads all the test_types from the folders in this directory
for folder in test_type_folders:
    # Regex that grabs the characters between "benchmarks/"
    # and the final "/" in the folder string to get the name
    test_type_name = re.findall(r'.+\/(.+)\/$', folder, re.M)[0]
    
    # Ignore generated __pycache__ folder
    if test_type_name == '__pycache__':
        continue
    
    # Update path to reflect new structure
    spec = importlib.util.spec_from_file_location("TestType", "%s%s.py" % (folder, test_type_name))
    
    # Ensure module loading from the specified path
    test_type = importlib.util.module_from_spec(spec)
    
    # Execute the module to load it
    spec.loader.exec_module(test_type)
    
    # Store the TestType class from the loaded module
    test_types[test_type_name] = test_type.TestType
