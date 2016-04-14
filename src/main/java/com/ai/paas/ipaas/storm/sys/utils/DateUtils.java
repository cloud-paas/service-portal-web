package com.ai.paas.ipaas.storm.sys.utils;

import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.ai.paas.ipaas.storm.sys.exception.DataException;
/**
 * 日期工具
 */
public class DateUtils{
	public static final long SECOND_1_MINUTE=60;
	public static final long SECOND_1_HOUR=60*60;
	public static final long SECOND_1_DAY=60*60*24;
	/**
	 * 获取当前日期和时间的中文显示
	 */
	public static String nowCn() {
		return new SimpleDateFormat("yyyy年MM月dd日 HH时:mm分:ss秒").format(new Date());
	}

	/**
	 * 获取当前日期和时间的英文显示
	 */
	public static String nowEn() {
		return new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date());
	}

	/**
	 * 获取当前日期的中文显示
	 */
	public static String nowDateCn() {
		return new SimpleDateFormat("yyyy年MM月dd日").format(new Date());
	}

	/**
	 * 获取当前日期的英文显示
	 */
	public static String nowDateEn() {
		return new SimpleDateFormat("yyyy-MM-dd").format(new Date());
	}

	/**
	 * 获取当前日期的yyyyMMdd显示
	 */
	public static String nowDateyyyyMMdd() {
		return new SimpleDateFormat("yyyyMMdd").format(new Date());
	}

	/**
	 * 获取当前日期的yyyyMM显示
	 */
	public static String nowDateyyyyMM() {
		return new SimpleDateFormat("yyyyMM").format(new Date());
	}

	/**
	 * 获取当前时间的中文显示
	 */
	public static String nowTimeCn() {
		return new SimpleDateFormat("HH时:mm分:ss秒").format(new Date());
	}

	/**
	 * 获取当前时间的英文显示
	 */
	public static String nowTimeEn() {
		return new SimpleDateFormat("HH:mm:ss").format(new Date());
	}

	/**
	 * 获取当前时间的英文显示
	 */
	public static String getNowDate() {
		return new SimpleDateFormat("yyyyMMddHHmmssSSS").format(new Date());
	}

	/**
	 * 获取某年某月第一天日期
	 */
	public static String getCurrMonthFirst(int year, int month, String format) {
		Calendar cal = Calendar.getInstance();
		cal.set(Calendar.YEAR, year);
		cal.set(Calendar.MONTH, month - 1);
		cal.set(Calendar.DAY_OF_MONTH, cal.getMinimum(Calendar.DATE));
		return new SimpleDateFormat(format).format(cal.getTime());
	}

	/**
	 * 获取某年某月最后一天日期
	 */
	public static String getCurrMonthLast(int year, int month, String format) {
		Calendar cal = Calendar.getInstance();
		cal.set(Calendar.YEAR, year);
		cal.set(Calendar.MONTH, month - 1);
		cal.set(Calendar.DAY_OF_MONTH, 1);
		int value = cal.getActualMaximum(Calendar.DAY_OF_MONTH);
		cal.set(Calendar.DAY_OF_MONTH, value);
		return new SimpleDateFormat(format).format(cal.getTime());
	}

	/**
	 * 获取当前月向前X个月的list
	 */
	public static List<Map<String, Object>> getPerMonth(int count) {
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		for (int i = 0; i < count; i++) {
			Calendar cal = Calendar.getInstance();
			cal.add(Calendar.MONTH, -i);
			Map<String, Object> map = new HashMap<String, Object>();
			int year = cal.get(Calendar.YEAR);
			int month = (cal.get(Calendar.MONTH) + 1);
			map.put("formatStr", year + "年" + month + "月");
			map.put("year", year);
			map.put("month", month);
			map.put("yyyyMM", String.valueOf(year) + (month < 10 ? "0" + month : month));
			list.add(map);
		}
		return list;
	}

	/**
	 * 获取当前毫秒数
	 */
	public static long getNowDateTime() {
		return (new Date()).getTime();
	}

	public static String timstamp2String(Timestamp timestamp) {
		if (timestamp == null)
			return "";
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");// 定义格式，不显示毫秒
		String str = df.format(timestamp);
		if (str != null && str.length() > 10)
			str = str.substring(0, 10);
		return str;
	}

	public static String timstamp3String(Timestamp timestamp) {
		if (timestamp == null)
			return "";
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");// 定义格式，不显示毫秒
		String str = df.format(timestamp);
		if (str != null && str.length() > 10)
			str = str.substring(0, 10);
		return str;
	}

	public static Timestamp string2Datestamp(String timestamp) throws Exception {
		if (timestamp == null || timestamp.length() < 10)
			return null;
		Timestamp ts = Timestamp.valueOf(timestamp.trim() + " 00:00:00");
		return ts;
	}

	public static Timestamp string2Timstamp(String timestamp) throws Exception {
		Timestamp ts = Timestamp.valueOf(timestamp);
		return ts;
	}

	public static long getNextMonthStartTime() {
		Calendar cal = Calendar.getInstance();
		int month = cal.get(Calendar.MONTH);
		int year = cal.get(Calendar.YEAR);
		if (month == 11) {
			year += 1;
			month = 0;
		} else {
			month += 1;
		}
		cal.set(Calendar.YEAR, year);
		cal.set(Calendar.MONTH, month);
		cal.set(Calendar.DAY_OF_MONTH, cal.getMinimum(Calendar.DATE));
		return cal.getTime().getTime();
	}

	public static String timstamp2Dt(Timestamp timestamp) {
		if (timestamp == null)
			return "";
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");// 定义格式，不显示毫秒
		String str = df.format(timestamp);
		return str;
	}
	public static String dateToyyyyMMdd(Date date){
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");// 定义格式，不显示毫秒
		return df.format(date);
	}
	public static String dateToyyyyMMdd_HH(Date date){
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH");// 定义格式，不显示毫秒
		return df.format(date);
	}
	public static String dateToyyyyMM(Date date){
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM");// 定义格式，不显示毫秒
		return df.format(date);
	}
	public static String dateToyyyy(Date date){
		SimpleDateFormat df = new SimpleDateFormat("yyyy");// 定义格式，不显示毫秒
		return df.format(date);
	}
	public static String dateToyyyyMMdd_HHmmss(Date date){
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");// 定义格式，不显示毫秒
		return df.format(date);
	}
	public static String dateToMMdd_HH(Date date){
		SimpleDateFormat df = new SimpleDateFormat("MM-dd HH");// 定义格式，不显示毫秒
		return df.format(date);
	}
	/**
	 * 是不是同一天
	 */
	public static boolean isOneDay(Date aDate,Date bDate){
		if (dateToyyyyMMdd(aDate).equals(dateToyyyyMMdd(bDate))) {
			return true;
		}else {
			return false;
		}
	}
	/**
	 * 两个日期相隔的天数
	 */
	public static int dayBetweenAb(Date aDate,Date bDate){
		Calendar aCalendar=Calendar.getInstance();
		aCalendar.setTime(aDate);
		aCalendar.set(Calendar.HOUR_OF_DAY, 0);
		aCalendar.set(Calendar.MINUTE, 0);
		aCalendar.set(Calendar.SECOND, 0);
		aCalendar.set(Calendar.MILLISECOND, 0);
		Calendar bCalendar=Calendar.getInstance();
		bCalendar.setTime(bDate);
		bCalendar.set(Calendar.HOUR_OF_DAY, 0);
		bCalendar.set(Calendar.MINUTE, 0);
		bCalendar.set(Calendar.SECOND, 0);
		bCalendar.set(Calendar.MILLISECOND, 0);
		return Math.abs((int)((aCalendar.getTimeInMillis()-bCalendar.getTimeInMillis())/(24*60*60*1000)));
	}
	/**
	 * yyyyMMdd格式的日期转换成Date
	 */
	public static Date yyyyMMddToDate(String yyyyMMdd){
		SimpleDateFormat df = new SimpleDateFormat("yyyyMMdd");
		try {
			return df.parse(yyyyMMdd);
		} catch (ParseException e) {
			throw new DataException("yyyyMMddToDate"+yyyyMMdd);
		}
	}
	/**
	 * yyyyMMdd格式的日期转换成Date
	 */
	public static Date yyyyMMddHHmmssToDate(String yyyyMMddHHmmss){
		SimpleDateFormat df = new SimpleDateFormat("yyyyMMddHHmmss");
		try {
			return df.parse(yyyyMMddHHmmss);
		} catch (ParseException e) {
			throw new DataException("yyyyMMddHHmmssToDate"+yyyyMMddHHmmss);
		}
	}
	/**
	 * yyyy-MM-dd格式的日期转换成Date
	 */
	public static Date yyyy_MM_ddToDate(String yyyy_MM_dd){
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
		try {
			return df.parse(yyyy_MM_dd);
		} catch (ParseException e) {
			throw new DataException("yyyy-MM-ddToDate"+yyyy_MM_dd);
		}
	}
	/**
	 * yyyy_MM_dd_HH_mm_ss格式的日期转换成Date
	 */
	public static Date yyyy_MM_dd_HH_mm_ssToDate(String yyyy_MM_dd_HH_mm_ss){
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		try {
			return df.parse(yyyy_MM_dd_HH_mm_ss);
		} catch (ParseException e) {
			throw new DataException("yyyy_MM_dd_HH_mm_ssToDate"+yyyy_MM_dd_HH_mm_ss);
		}
	}
	/**
	 * 几天之后
	 */
	public static Date afterDays(int days){
		Calendar calendar=Calendar.getInstance();
		calendar.add(Calendar.DAY_OF_MONTH, days);
		return calendar.getTime();
	}
	/**
	 * 10小时前的00分:00秒 000
	 */
	public static Date hour10Start(){
		Calendar calendar=Calendar.getInstance();
		calendar.add(Calendar.HOUR_OF_DAY, -10);
		calendar.set(Calendar.MINUTE, 0);
		calendar.set(Calendar.SECOND, 0);
		calendar.set(Calendar.MILLISECOND, 0);
		return calendar.getTime();
	}
	/**
	 * 今天的00:00:00 000
	 */
	public static Date todayStart(){
		Calendar calendar=Calendar.getInstance();
		calendar.set(Calendar.HOUR_OF_DAY, 0);
		calendar.set(Calendar.MINUTE, 0);
		calendar.set(Calendar.SECOND, 0);
		calendar.set(Calendar.MILLISECOND, 0);
		return calendar.getTime();
	}
	/**
	 * 今天的23:59:59 999
	 */
	public static Date todayEnd(){
		Calendar calendar=Calendar.getInstance();
		calendar.add(Calendar.DAY_OF_MONTH, 1);
		calendar.set(Calendar.HOUR_OF_DAY, 0);
		calendar.set(Calendar.MINUTE, 0);
		calendar.set(Calendar.SECOND, 0);
		calendar.add(Calendar.MILLISECOND, -1);
		return calendar.getTime();
	}
	/**
	 * 一周前的00:00:00 000
	 */
	public static Date weekStart(){
		Calendar calendar=Calendar.getInstance();
		calendar.add(Calendar.WEEK_OF_MONTH, -1);
		calendar.set(Calendar.HOUR_OF_DAY, 0);
		calendar.set(Calendar.MINUTE, 0);
		calendar.set(Calendar.SECOND, 0);
		calendar.set(Calendar.MILLISECOND, 0);
		return calendar.getTime();
	}
	/**
	 * 一月前的00:00:00 000
	 */
	public static Date monthStart(){
		Calendar calendar=Calendar.getInstance();
		calendar.add(Calendar.MONTH, -1);
		calendar.set(Calendar.HOUR_OF_DAY, 0);
		calendar.set(Calendar.MINUTE, 0);
		calendar.set(Calendar.SECOND, 0);
		calendar.set(Calendar.MILLISECOND, 0);
		return calendar.getTime();
	}
	/**
	 * 一年前的00:00:00 000
	 */
	public static Date yearStart(){
		Calendar calendar=Calendar.getInstance();
		calendar.add(Calendar.YEAR, -1);
		calendar.set(Calendar.HOUR_OF_DAY, 0);
		calendar.set(Calendar.MINUTE, 0);
		calendar.set(Calendar.SECOND, 0);
		calendar.set(Calendar.MILLISECOND, 0);
		return calendar.getTime();
	}
	/**
	 * 10年前的00:00:00 000
	 */
	public static Date year10Start(){
		Calendar calendar=Calendar.getInstance();
		calendar.add(Calendar.YEAR, -10);
		calendar.set(Calendar.HOUR_OF_DAY, 0);
		calendar.set(Calendar.MINUTE, 0);
		calendar.set(Calendar.SECOND, 0);
		calendar.set(Calendar.MILLISECOND, 0);
		return calendar.getTime();
	}
}
