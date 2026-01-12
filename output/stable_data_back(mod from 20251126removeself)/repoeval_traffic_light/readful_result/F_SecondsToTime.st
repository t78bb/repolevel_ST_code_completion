// 将秒数（DWORD）转换为TIME类型
    // TIME类型是以毫秒为单位存储的，因此需要将秒数乘以1000
    F_SecondsToTime := DWORD_TO_TIME(dwSeconds * 1000);