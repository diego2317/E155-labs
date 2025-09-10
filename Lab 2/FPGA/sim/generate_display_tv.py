# gen_display_controller_vectors.py
# Writes all test vectors to display_vectors.txt
# Line format: s1[3:0]_s2[3:0]_t1_t2_seg[6:0]

hexInputs = [
    "0000","0001","0010","0011",
    "0100","0101","0110","0111",
    "1000","1001","1010","1011",
    "1100","1101","1110","1111",
]

segOutputs = {
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

def main(out_path="display_controller_tv.txt"):
    count = 0
    with open(out_path, "w", newline="\n") as f:
        for s1 in hexInputs:
            for s2 in hexInputs:
                for t1 in (0, 1):          # toggle (and t1) state
                    t2 = 1 - t1             # complement
                    sel = s2 if t1 else s1  # mux selection based on toggle
                    seg = segOutputs[sel]   # expected 7-seg
                    f.write(f"{s1}_{s2}_{t1}_{t2}_{seg}\n")
                    count += 1
    print(f"Wrote {count} vectors to {out_path}")

if __name__ == "__main__":
    main()
