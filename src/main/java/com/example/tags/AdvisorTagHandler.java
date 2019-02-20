package com.example.tags;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.SimpleTagSupport;
import java.io.IOException;

public class AdvisorTagHandler extends SimpleTagSupport {
	private String user;
	
	@Override
	public void doTag() throws JspException, IOException {
		getJspContext().getOut().write("Hello " + user + "<br>");
		getJspContext().getOut().write("Your advice is " + getAdvice());
	}
	
	public void setUser(String user) {
		this.user = user;
	}

	private String getAdvice() {
		String[] adviceStrings = {"That color's not working for you.", "You should call in sick.",
				"You might want to rethink that haircut."};
		int random = (int) (Math.random() * adviceStrings.length);
		return adviceStrings[random];
		
	}

}
