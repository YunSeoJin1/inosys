package ino.web.freeBoard.common.util;

import java.util.Date;

public class StringUtil {

	public static String nullCheck(Object param) {
		  String str = new String();

		  if (param == null) {
		   return "";
		  }

		  if (param instanceof String) {
		   str = (String) param;
		  } else if (param instanceof String[]) {
		   str = ((String[]) param)[0];
		  } else if (param instanceof Date) {
		   str = ((Date)param).toString();
		  } else {
		   str = String.valueOf(param);
		  }

		  if (str.equals("")) {
		   return "";
		  } else {
		   return str.trim();
		  }
		 }

}
