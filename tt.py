def generate_binary_to_decimal():
    for binary in range(60):
        binary_string = f"{binary:06b}"
        decimal = int(binary_string, 2)
        print(f"6'b{binary_string}: begin")
        print(f"    decimal1 = 4'd{decimal // 10};")
        print(f"    decimal2 = 4'd{decimal % 10};")
        print("end")


generate_binary_to_decimal()
