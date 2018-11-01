package edu.iot.common.model;

import java.util.Date;

import org.hibernate.validator.constraints.NotEmpty;
import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class Todo {
	private long toDoId;
	@NotEmpty(message="제목은 필수 항목 입니다")
	private String title;
	@NotEmpty(message="내용을 입력해주세요")
	private String content;
	private int priority;
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date deadLine;
	private int checked;
	private Date regDate;
	private Date updateDate;
}
