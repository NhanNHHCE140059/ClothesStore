package misc;

import java.sql.Date;
import java.text.DateFormat;
import java.util.Locale;

/**
 *
 * @author Huenh
 */
public class Parser {
    private static String date_to_string(Date s) {
        Locale locale = new Locale("us", "VI");
        DateFormat dateFormat = DateFormat.getDateInstance(DateFormat.DEFAULT, locale);
        String date = dateFormat.format(s);
        return date;
    }
}
