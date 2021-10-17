/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package helper;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.Period;
import java.util.Calendar;
import java.util.Date;

/**
 *
 * @author Yap Zhen Yie
 */
public class DateTimeHelper {

    public static int getAge(LocalDate dateOfBirth) {
        Period period = Period.between(dateOfBirth, LocalDate.now());
        return period.getYears();
    }

    public static Date getCurrentDate() throws ParseException {
        SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
        return formatter.parse(formatter.format(new Date()));
    }

    public static String getCurrentDateISOFormat(Date date) throws ParseException {
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
        return formatter.format(date);
    }

    public static Date getDate(int days) throws ParseException {
        Date date = getCurrentDate();
        Calendar c = Calendar.getInstance();
        c.setTime(date);
        c.add(Calendar.DATE, days);
        date = c.getTime();
        return date;
    }
}
