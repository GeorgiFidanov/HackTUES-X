# Open a file named "temp.txt" in write mode
with open("temp.txt", "w") as file:
    # Write the text "kaka mi se" into the file
    file.write("kaka mi se\n")

print("File 'temp.txt' has been created with the text 'kaka mi se'.")
