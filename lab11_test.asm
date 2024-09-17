li $t0, 0x8000000B  # Giá trị của thanh ghi Cause
andi $t1, $t0, 0xFC000000  # Áp dụng bit mask 0xFC000000 để giữ lại 6 bit đầu
srl $t1, $t1, 26  # Dịch bit sang phải 26 lần để đưa 6 bit đầu về vị trí đúng

# Giá trị của 6 bit đầu trong ExcCode được lưu trong $t1
