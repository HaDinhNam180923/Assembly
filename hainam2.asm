.data
    xau:    .space 100    # Định nghĩa một mảng lưu trữ xâu ký tự, có kích thước tối đa 100 byte
    ky_tu:  .space 1      # Định nghĩa một biến lưu trữ ký tự C
    count:  .word 0       # Định nghĩa một biến lưu trữ số lần xuất hiện của ký tự C

.text
    main:
        # Nhập xâu ký tự từ bàn phím
        li $v0, 8           # Hệ thống gọi số 8: đọc xâu ký tự từ bàn phím
        la $a0, xau         # Địa chỉ bắt đầu của mảng lưu trữ xâu
        li $a1, 100         # Độ dài tối đa của xâu
        syscall

        # Nhập ký tự C từ bàn phím
        li $v0, 8           # Hệ thống gọi số 8: đọc ký tự từ bàn phím
        la $a0, ky_tu       # Địa chỉ của biến lưu trữ ký tự C
        li $a1, 2           # Độ dài tối đa của ký tự
        syscall

        # Đếm số lần xuất hiện ký tự C trong xâu
        li $s0, 0           # Số lần xuất hiện ban đầu được đặt là 0
        la $s1, xau         # Con trỏ trỏ đến đầu xâu

    loop_start:
        lb $t0, 0($s1)      # Đọc ký tự hiện tại từ xâu
        beqz $t0, loop_end  # Nếu là ký tự kết thúc xâu, thoát khỏi vòng lặp

        lb $t1, ky_tu       # Lấy ký tự C từ biến lưu trữ
        sub $t2, $t0, $t1   # So sánh ký tự hiện tại với ký tự C
        beqz $t2, found     # Nếu hai ký tự giống nhau, chuyển đến nhãn found

        addiu $s1, $s1, 1   # Tăng con trỏ để trỏ tới ký tự tiếp theo trong xâu
        j loop_start        # Quay lại đầu vòng lặp

    found:
        addiu $s0, $s0, 1   # Tăng số lần xuất hiện của ký tự C
        addiu $s1, $s1, 1   # Tăng con trỏ để trỏ tới ký tự tiếp theo trong xâu
        j loop_start        # Quay lại đầu vòng lặp

    loop_end: 