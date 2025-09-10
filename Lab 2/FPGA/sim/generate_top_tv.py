# gen_display_controller_vectors_with_led.py
# Writes all test vectors to display_vectors.txt
# Format per line: s1[3:0]_s2[3:0]_t1_t2_seg[6:0]_led[4:0]

inputs = [
    "0000","0001","0010","0011",
    "0100","0101","0110","0111",
    "1000","1001","1010","1011",
    "1100","1101","1110","1111",
]

outputs = {
    "0000": "1000000",
    "0001": "1111001",
    "0010": "0100100",
    "0011": "0110000",
    "0100": "0011001",
    "0101": "0010010",
    "0110": "0000010",
    "0111": "1111000",
    "1000": "0000000",
    "1001": "0011000",
    "1010": "0001000",
    "1011": "0000011",
    "1100": "1000110",
    "1101": "0100001",
    "1110": "0000110",
    "1111": "0001110",
}

def bits(n, width): 
    return format(n, f"0{width}b")

def main(out_path="lab2_dw_tv.txt"):
    count = 0
    with open(out_path, "w", newline="\n") as f:
        for s1 in inputs:
            for s2 in inputs:
                # 5-bit sum for led
                led_val = int(s1, 2) + int(s2, 2)    # 0..30
                led_bits = bits(led_val, 5)
                # Test both toggle states
                for t1 in (0, 1):
                    t2 = 1 - t1
                    sel = s2 if t1 else s1
                    seg = outputs[sel]
                    f.write(f"{s1}_{s2}_{t1}_{t2}_{seg}_{led_bits}\n")
                    count += 1
    print(f"Wrote {count} vectors to {out_path}")

if __name__ == "__main__":
    main()
