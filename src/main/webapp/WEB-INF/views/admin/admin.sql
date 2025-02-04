CREATE TABLE schedule (
  idx INT AUTO_INCREMENT PRIMARY KEY,
  title VARCHAR(100) NOT NULL,     -- 일정 제목
  startDate DATE NOT NULL,        -- 일정 시작 날짜
  endDate DATE                   -- 일정 종료 날짜 (선택 사항)
);