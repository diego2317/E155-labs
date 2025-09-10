# gen_adder_vectors.py
# Generates all test vectors for adding two 4-bit signals (unsigned).
# Output format per line: s1[3:0]_s2[3:0]_led[4:0]
# Writes to vectors.txt in the current directory.

def bits(n, width):
    return format(n, f"0{width}b")

def main(out_path="led_controller_tv.txt"):
    with open(out_path, "w", newline="\n") as f:
        for s1 in range(16):          # 0..15 (4-bit)
            for s2 in range(16):      # 0..15 (4-bit)
                s = s1 + s2           # 0..30 (fits in 5 bits)
                line = f"{bits(s1,4)}_{bits(s2,4)}_{bits(s,5)}"
                f.write(line + "\n")
    print(f"Wrote 256 vectors to {out_path}")

if __name__ == "__main__":
    main()
