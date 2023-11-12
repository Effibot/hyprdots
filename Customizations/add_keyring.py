"""Script to add the keyring option to the vscode arg.json file"""

import os

# Get the path to the vscode arg.json file
argv_file = os.path.expanduser("~/.vscode/argv.json")
# Load the json file
with open(argv_file, "r") as f:
    argv = f.read()
# find the last } and add the keyring option
argv = argv[: argv.rfind("}")] + ', \t"password-store": "kwallet5"\n}'
# Write the new json file
with open(argv_file, "w") as f:
    f.write(argv)
# Exit
