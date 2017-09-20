/*
    Weave (Web-based Analysis and Visualization Environment)
    Copyright (C) 2008-2011 University of Massachusetts Lowell

    This file is a part of Weave.

    Weave is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License, Version 3,
    as published by the Free Software Foundation.

    Weave is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with Weave.  If not, see <http://www.gnu.org/licenses/>.
*/

package azura.avalon.zbase.kd
{
	import flash.utils.ByteArray;
	import flash.utils.getQualifiedClassName;
	import flash.utils.getTimer;
	
	import mx.formatters.DateFormatter;
	import mx.formatters.NumberFormatter;
	import mx.utils.ObjectUtil;
	import mx.utils.StringUtil;
	
//	import weave.flascc.FlasCC;
//	import weave.utils.AsyncSort;
//	import weave.utils.CustomDateFormatter;
//	import weave.utils.DebugTimer;

	/**
	 * This provides a set of useful static functions.
	 * All the functions defined in this class are pure functions, meaning they always return the same result with the same arguments, and they have no side-effects.
	 * 
	 * @author adufilie
	 */
	public class StandardLib
	{
		/**
		 * This function will cast a value of any type to a Number,
		 * interpreting the empty string ("") and null as NaN.
		 * @param value A value to cast to a Number.
		 * @return The value cast to a Number, or NaN if the casting failed.
		 */
		public static function asNumber(value:*):Number
		{
			if (value == null)
				return NaN; // return NaN because Number(null) == 0
			
			if (value is Number || value is Date)
				return value;
			
			try {
				value = String(value);
				if (value == '')
					return NaN; // return NaN because Number('') == 0
				return Number(value);
			} catch (e:Error) { }

			return NaN;
		}
		
		/**
		 * Converts a value to a non-null String
		 * @param value A value to cast to a String.
		 * @return The value cast to a String.
		 */
		public static function asString(value:*):String
		{
			if (value == null)
				return '';
			try
			{
				return value;
			}
			catch (e:Error) { }
			return '';
		}
		
		/**
		 * This function attempts to derive a boolean value from different types of objects.
		 * @param value An object to parse as a Boolean.
		 */
		public static function asBoolean(value:*):Boolean
		{
			if (value is Boolean)
				return value;
			if (value is String)
				return ObjectUtil.stringCompare(value, "true", true) == 0;
			if (isNaN(value))
				return false;
			if (value is Number)
				return value != 0;
			return value;
		}
		
		/**
		 * Tests if a value is anything other than undefined, null, or NaN.
		 */
		public static function isDefined(value:*):Boolean
		{
			return value !== undefined && value !== null && !(value is Number && isNaN(value));
		}
		
		/**
		 * Tests if a value is undefined, null, or NaN.
		 */
		public static function isUndefined(value:*):Boolean
		{
			return value === undefined || value === null || (value is Number && isNaN(value));
		}
		
		/**
		 * Pads a string on the left.
		 */
		public static function lpad(str:String, length:uint, padString:String = ' '):String
		{
			if (str.length >= length)
				return str;
			while (str.length + padString.length < length)
				padString += padString;
			return padString.substr(0, length - str.length) + str;
		}
		
		/**
		 * Pads a string on the right.
		 */
		public static function rpad(str:String, length:uint, padString:String = ' '):String
		{
			if (str.length >= length)
				return str;
			while (str.length + padString.length < length)
				padString += padString;
			return str + padString.substr(0, length - str.length);
		}
		
		/**
		 * This function performs find and replace operations on a String.
		 * @param string A String to perform replacements on.
		 * @param findStr A String to find.
		 * @param replaceStr A String to replace occurrances of the 'findStr' String with.
		 * @param moreFindAndReplace A list of additional find,replace parameters to use.
		 * @return The String with all the specified replacements performed.
		 */
		public static function replace(string:String, findStr:String, replaceStr:String, ...moreFindAndReplace):String
		{
			string = string.split(findStr).join(replaceStr);
			while (moreFindAndReplace.length > 1)
			{
				findStr = moreFindAndReplace.shift();
				replaceStr = moreFindAndReplace.shift();
				string = string.split(findStr).join(replaceStr);
			}
			return string;
		}
		
		private static const argRef:RegExp = new RegExp("^(0|[1-9][0-9]*)\}");
		
		/**
		 * Substitutes "{n}" tokens within the specified string with the respective arguments passed in.
		 * Same syntax as StringUtil.substitute() without the side-effects of using String.replace() with a regex.
		 * @see String#replace()
		 * @see mx.utils.StringUtil#substitute()
		 */
		public static function substitute(format:String, ...args):String
		{
			if (args.length == 1 && args[0] is Array)
				args = args[0] as Array;
			var split:Array = format.split('{')
			var output:String = split[0];
			for (var i:int = 1; i < split.length; i++)
			{
				var str:String = split[i] as String;
				if (argRef.test(str))
				{
					var j:int = str.indexOf("}");
					output += args[str.substring(0, j)];
					output += str.substring(j + 1);
				}
				else
					output += "{" + str;
			}
			return output;
		}
		
		/**
		 * Takes a script where all lines have been indented with tabs,
		 * removes the common indentation from all lines and optionally
		 * replaces extra leading tabs with a number of spaces.
		 * @param script A script.
		 * @param spacesPerTab If zero or greater, this is the number of spaces to be used in place of each tab character used as indentation.
		 * @return The modified script.
		 */		
		public static function unIndent(script:String, spacesPerTab:int = -1):String
		{
			if (script == null)
				return null;
			// switch all line endings to \n
			script = replace(script, '\r\n', '\n', '\r', '\n');
			// remove trailing whitespace (not leading whitespace)
			script = StringUtil.trim('.' + script).substr(1);
			// separate into lines
			var lines:Array = script.split('\n');
			// remove blank lines from the beginning
			while (lines.length && !StringUtil.trim(lines[0]))
				lines.shift();
			// stop if there's nothing left
			if (!lines.length)
				return '';
			// find the common indentation
			var commonIndent:int = int.MAX_VALUE;
			var line:String;
			for each (line in lines)
			{
				// ignore blank lines
				if (!StringUtil.trim(line))
					continue;
				// count leading tabs
				var lineIndent:int = 0;
				while (line.charAt(lineIndent) == '\t')
					lineIndent++;
				// remember the minimum number of leading tabs
				commonIndent = Math.min(commonIndent, lineIndent);
			}
			// remove the common indentation from each line
			for (var i:int = 0; i < lines.length; i++)
			{
				line = lines[i];
				// prepare to remove common indentation
				var t:int = 0;
				while (t < commonIndent && line.charAt(t) == '\t')
					t++;
				// optionally, prepare to replace extra tabs with spaces
				var spaces:String = '';
				if (spacesPerTab >= 0)
				{
					while (line.charAt(t) == '\t')
					{
						spaces += lpad('', spacesPerTab, '        ');
						t++;
					}
				}
				// commit changes
				lines[i] = spaces + line.substr(t);
			}
			return lines.join('\n');
		}

		/**
		 * Converts a number to a String using a specific numeric base and optionally pads with leading zeros.
		 * @param number The Number to convert to a String.
		 * @param base Specifies the numeric base (from 2 to 36) to use.
		 * @param zeroPad This is the minimum number of digits to return.  The number will be padded with zeros if necessary.
		 * @return The String representation of the number using the specified numeric base.
		 */
		public static function numberToBase(number:Number, base:int = 10, zeroPad:int = 1):String
		{
			var parts:Array = Math.abs(number).toString(base).split('.');
			if (parts[0].length < zeroPad)
				parts[0] = lpad(parts[0], zeroPad, '0');
			if (number < 0)
				parts[0] = '-' + parts[0];
			return parts.join('.');
		}
		
		/**
		 * This function will use a default NumberFormatter object to format a Number to a String.
		 * @param number The number to format.
		 * @param precision A precision value to pass to the default NumberFormatter.
		 * @return The result of format(number) using the specified precision value.
		 * @see mx.formatters.NumberFormatter#format
		 */
		public static function formatNumber(number:Number, precision:Number = NaN):String
		{
			if (isFinite(precision))
			{
				_numberFormatter.precision = uint(precision);
			}
			else
			{
				number = StandardLib.roundSignificant(number);
				if (Math.abs(number) < 1)
					return String(number); // this fixes the bug where "0.1" gets converted to ".1" (we don't want the "0" to be lost)
				_numberFormatter.precision = -1;
			}
			
			return _numberFormatter.format(number);
		}
		
		/**
		 * This is the default NumberFormatter to use inside the formatNumber() function.
		 */
		private static const _numberFormatter:NumberFormatter = new NumberFormatter();

		/**
		 * This function returns -1 if the given value is negative, and 1 otherwise.
		 * @param value A value to test.
		 * @return -1 if value &lt; 0, 1 otherwise
		 */
		public static function sign(value:Number):Number
		{
			if (value < 0)
				return -1;
			return 1;
		}
		
		/**
		 * This function constrains a number between min and max values.
		 * @param value A value to constrain between a min and max.
		 * @param min The minimum value.
		 * @param max The maximum value.
		 * @return If value &lt; min, returns min.  If value &gt; max, returns max.  Otherwise, returns value.
		 */
		public static function constrain(value:Number, min:Number, max:Number):Number
		{
			if (value < min)
				return min;
			if (value > max)
				return max;
			return value;
		}
		
		/**
		 * Scales a number between 0 and 1 using specified min and max values.
		 * @param value The value between min and max.
		 * @param min The minimum value that corresponds to a result of 0.
		 * @param max The maximum value that corresponds to a result of 1.
		 * @return The normalized value between 0 and 1, or NaN if value is out of range.
		 */
		public static function normalize(value:Number, min:Number, max:Number):Number
		{
			if (value < min || value > max)
				return NaN;
			if (min == max)
				return value - min; // min -> 0; NaN -> NaN
			return (value - min) / (max - min);
		}

		/**
		 * This function performs a linear scaling of a value from an input min,max range to an output min,max range.
		 * @param inputValue A value to scale.
		 * @param inputMin The minimum value in the input range.
		 * @param inputMax The maximum value in the input range.
		 * @param outputMin The minimum value in the output range.
		 * @param outputMax The maximum value in the output range.
		 * @return The input value rescaled such that a value equal to inputMin is scaled to outputMin and a value equal to inputMax is scaled to outputMax.
		 */
		public static function scale(inputValue:Number, inputMin:Number, inputMax:Number, outputMin:Number, outputMax:Number):Number
		{
			if (inputMin == inputMax)
			{
				if (isNaN(inputValue))
					return NaN;
				if (inputValue > inputMax)
					return outputMax;
				return outputMin;
			}
			return outputMin + (outputMax - outputMin) * (inputValue - inputMin) / (inputMax - inputMin);
		}

		/**
		 * This rounds a Number to a given number of significant digits.
		 * @param value A value to round.
		 * @param significantDigits The desired number of significant digits in the result.
		 * @return The number, rounded to the specified number of significant digits.
		 */
		public static function roundSignificant(value:Number, significantDigits:uint = 14):Number
		{
			// it doesn't make sense to round infinity or NaN
			if (!isFinite(value))
				return value;
			
			var sign:Number = (value < 0) ? -1 : 1;
			var absValue:Number = Math.abs(value);
			var pow10:Number;
			
			// if absValue is less than 1, all digits after the decimal point are significant
			if (absValue < 1)
			{
				pow10 = Math.pow(10, significantDigits);
				//trace("absValue<1: Math.round(",absValue,"*",pow10,")",Math.round(absValue * pow10));
				return sign * Math.round(absValue * pow10) / pow10;
			}
			
			var log10:Number = Math.ceil(Math.log(absValue) / Math.LN10);
			
			// Both these calculations are equivalent mathematically, but if we use
			// the wrong one we get bad rounding results like "123.456000000001".
			if (log10 < significantDigits)
			{
				// find the power of 10 that you need to MULTIPLY absValue by
				// so Math.round() will round off the digits we don't want
				pow10 = Math.pow(10, significantDigits - log10);
				return sign * Math.round(absValue * pow10) / pow10;
			}
			else
			{
				// find the power of 10 that you need to DIVIDE absValue by
				// so Math.round() will round off the digits we don't want
				pow10 = Math.pow(10, log10 - significantDigits);
				//trace("log10>significantDigits: Math.round(",absValue,"/",pow10,")",Math.round(absValue / pow10));
				return sign * Math.round(absValue / pow10) * pow10;
			}
		}
		
		//testRoundSignificant();
		private static function testRoundSignificant():void
		{
			for (var pow:int = -5; pow <= 5; pow++)
			{
				var n:Number = 1234.5678 * Math.pow(10, pow);
				for (var d:int = 0; d <= 9; d++)
					trace('roundSignificant(',n,',',d,') =',roundSignificant(n, d));
			}
		}

		/**
		 * Calculates an interpolated color for a normalized value.
		 * @param normValue A Number between 0 and 1.
		 * @param colors An Array or list of colors to interpolate between.  Normalized values of 0 and 1 will be mapped to the first and last colors.
		 * @return An interpolated color associated with the given normValue based on the list of color values.
		 */
		public static function interpolateColor(normValue:Number, ...colors):Number
		{
			// handle an array of colors as the second parameter
			if (colors.length == 1 && colors[0] is Array)
				colors = colors[0];
			
			// handle invalid parameters
			if (normValue < 0 || normValue > 1 || colors.length == 0)
				return NaN;
			
			// find the min and max colors we want to interpolate between
			
			var maxIndex:int = colors.length - 1;
			var leftIndex:int = maxIndex * normValue;
			var rightIndex:int = leftIndex + 1;
			
			// handle boundary condition
			if (rightIndex == colors.length)
				return colors[leftIndex];
			
			var minColor:Number = colors[leftIndex];
			var maxColor:Number = colors[rightIndex];
			// normalize the norm value between the two norm values associated with the surrounding colors
			normValue = normValue * maxIndex - leftIndex;
			
			var percentLeft:Number = 1 - normValue; // relevance of minColor
			var percentRight:Number = normValue; // relevance of maxColor
			const R:int = 0xFF0000;
			const G:int = 0x00FF00;
			const B:int = 0x0000FF;
			return (
				((percentLeft * (minColor & R) + percentRight * (maxColor & R)) & R) |
				((percentLeft * (minColor & G) + percentRight * (maxColor & G)) & G) |
				((percentLeft * (minColor & B) + percentRight * (maxColor & B)) & B)
			);
		}
		
		/**
		 * Code from Graphics Gems Volume 1
		 */
		public static function getNiceNumber(x:Number, round:Boolean):Number
		{
			var exponent:Number;
			var fractionalPart:Number;
			var niceFractionalPart:Number;
			
			// special case for nice number of 0, since Math.log(0) is -Infinity
			if(x == 0)
				return 0;
			
			exponent = Math.floor( Math.log( x ) / Math.LN10 );
			fractionalPart = x / Math.pow( 10.0, exponent );
			
			if( round ) {
				if( fractionalPart < 1.5 ) {
					niceFractionalPart = 1.0;
				} else if( fractionalPart < 3.0 ) {
					niceFractionalPart = 2.0;
				} else if( fractionalPart < 7.0 ) {
					niceFractionalPart = 5.0;
				} else {
					niceFractionalPart = 10.0;
				}
			} else {
				if( fractionalPart <= 1.0 ) {
					niceFractionalPart = 1.0;
				} else if( fractionalPart <= 2.0 ) {
					niceFractionalPart = 2.0;
				} else if( fractionalPart < 5.0 ) {
					niceFractionalPart = 5.0;
				} else {
					niceFractionalPart = 10.0;
				}
			}
			
			return niceFractionalPart * Math.pow( 10.0, exponent );
		}
		
		/**
		 * Code from Graphics Gems Volume 1
		 * Note: This may return less than the requested number of values
		 */
		public static function getNiceNumbersInRange(min:Number, max:Number, numberOfValuesInRange:int):Array
		{
			// special case
			if (min == max)
				return [min];
			
			var nfrac:int;
			var d:Number;
			var graphmin:Number;
			var graphmax:Number;
			var range:Number;
			var x:Number;
			var i:int = 0;
			
			var values:Array = [];
			
			// Bug fix: getNiceNumbersInRange(0, 500, 6) returned [0,200,400] when it could be [0,100,200,300,400,500]
			// Was: range = getNiceNumber(max - min, false);
			range = max - min;
			
			d = getNiceNumber( range / (numberOfValuesInRange - 1), true);
			graphmin = Math.floor(min / d) * d;
			graphmax = Math.ceil(max / d) * d;
			
			nfrac = Math.max(-Math.floor(Math.log(d)/Math.LN10), 0);
			
			for(x = graphmin; x < graphmax + 0.5*d; x += d)
			{
				values[i++] = roundSignificant(x); // this fixes values like x = 0.6000000000000001 that may occur from x += d
			}
			
			return values;
		}
		
		/**
		 * Calculates the mean value from a list of Numbers.
		 */
		public static function mean(...args):Number
		{
			if (args.length == 1 && args[0] is Array)
				args = args[0];
			var sum:Number = 0;
			for each (var value:Number in args)
				sum += value;
			return sum / args.length;
		}
		
		/**
		 * Calculates the sum of a list of Numbers.
		 */
		public static function sum(...args):Number
		{
			if (args.length == 1 && args[0] is Array)
				args = args[0];
			var sum:Number = 0;
			for each (var value:Number in args)
				sum += value;
			return sum;
		}
		
//		/**
//		 * This uses AsyncSort.sortImmediately() to sort an Array (or Vector) in place.
//		 * @param array An Array (or Vector) to sort.
//		 * @param compare A function that accepts two items and returns -1, 0, or 1.
//		 * @see weave.utils.AsyncSort#sortImmediately()
//		 * @see Array#sort()
//		 */		
//		public static function sort(array:*, compare:Function = null):void
//		{
//			AsyncSort.sortImmediately(array, compare);
//		}
		
		private static const _sortBuffer:Array = [];
		
		/**
		 * Sorts an Array (or Vector) of items in place using properties, lookup tables, or replacer functions.
		 * @param array An Array (or Vector) to sort.
		 * @param params Specifies how to get values used to sort items in the array.
		 *               This can either be an Array of params or a single param, each of which can be one of the following:<br>
		 *               Array or Vector: values are looked up based on index (Such an Array must be nested in a params array rather than given alone as a single param)<br>
		 *               Object or Dictionary: values are looked up using items in the array as keys<br>
		 *               Property name: values are taken from items in the array using a property name<br>
		 *               Replacer function: array items are passed through this function to get values<br>
		 * @param sortDirections Specifies sort direction(s) (1 or -1) corresponding to the params.
		 * @param inPlace Set this to true to modify the original Array (or Vector) in place or false to return a new, sorted copy.
		 * @param returnSortedIndexArray Set this to true to return a new Array of sorted indices.
		 * @return Either the original Array (or Vector) or a new one.
		 * @see Array#sortOn()
		 */
		public static function sortOn(array:*, params:*, sortDirections:* = undefined, inPlace:Boolean = true, returnSortedIndexArray:Boolean = false):*
		{
			if (array.length == 0)
				return inPlace ? array : [];
			
			var values:Array;
			var param:*;
			var sortDirection:int;
			var i:int;
			
			// expand _sortBuffer as necessary
			for (i = _sortBuffer.length; i < array.length; i++)
				_sortBuffer[i] = [];
			
			// If there is only one param, wrap it in an array.
			// Array.sortOn() is preferred over Array.sort() in this case
			// since an undefined value will crash Array.sort(Array.NUMERIC).
			if (params === array || !(params is Array))
			{
				params = [params];
				if (sortDirections)
					sortDirections = [sortDirections];
			}
			
			var fields:Array = new Array(params.length);
			var fieldOptions:Array = new Array(params.length);
			for (var p:int = 0; p < params.length; p++)
			{
				param = params[p];
				sortDirection = sortDirections && sortDirections[p] < 0 ? Array.DESCENDING : 0;
				
				i = array.length;
				if (param is Array || param is Vector)
					while (i--)
						_sortBuffer[i][p] = param[i];
				else if (param is Function)
					while (i--)
						_sortBuffer[i][p] = param(array[i]);
				else if (typeof param === 'object')
					while (i--)
						_sortBuffer[i][p] = param[array[i]];
				else
					while (i--)
						_sortBuffer[i][p] = array[i][param];
				
				fields[p] = p;
				fieldOptions[p] = Array.RETURNINDEXEDARRAY | guessSortMode(_sortBuffer[0][p]) | sortDirection;
			}
			
			values = _sortBuffer.slice(0, array.length);
			values = values.sortOn(fields, fieldOptions);
			
			if (returnSortedIndexArray)
				return values;
			
			var array2:Array = new Array(array.length);
			i = array.length;
			while (i--)
				array2[i] = array[values[i]];
			
			if (!inPlace)
				return array2;
			
			i = array.length;
			while (i--)
				array[i] = array2[i];
			return array;
		}
		
		/**
		 * Guesses the appropriate Array.sort() mode based on a sample item from an Array.
		 * @return Either Array.NUMERIC or 0.
		 */
		private static function guessSortMode(sampleItem:Object):int
		{
			return sampleItem is Number || sampleItem is Date ? Array.NUMERIC : 0;
		}
		
		/**
		 * This will return the type of item found in the Array if each item has the same type.
		 * @param a An Array to check.
		 * @return The type of all items in the Array, or null if the types differ. 
		 */
		public static function getArrayType(a:Array):Class
		{
			if (a == null || a.length == 0 || a[0] == null)
				return null;
			var type:Class = Object(a[0]).constructor;
			for each (var item:Object in a)
				if (item == null || item.constructor != type)
					return null;
			return type;
		}
		
		/**
		 * This will perform a log transformation on a normalized value to produce another normalized value.
		 * @param normValue A number between 0 and 1.
		 * @param factor The log factor to use.
		 * @return A number between 0 and 1.
		 */
		public static function logTransform(normValue:Number, factor:Number = 1024):Number
		{
			return Math.log(1 + normValue * factor) / Math.log(1 + factor);
		}
		
//		/**
//		 * This will parse a date string into a Date object.
//		 * @param dateString The date string to parse.
//		 * @param formatString The format of the date string.
//		 * @param parseAsUniversalTime If set to true, the date string will be parsed as universal time.
//		 *        If set to false, the timezone of the user's computer will be used.
//		 * @return The resulting Date object.
//		 * 
//		 * @see mx.formatters::DateFormatter#formatString
//		 * @see Date
//		 */		
//		public static function parseDate(dateString:String, formatString:String = null, parseAsUniversalTime:Boolean = true):Date
//		{
//			var formattedDateString:String = dateString;
//			if (formatString)
//			{
//				_dateFormatter.formatString = formatString;
//				formattedDateString = _dateFormatter.format(dateString);
//				if (_dateFormatter.error)
//					throw new Error(_dateFormatter.error);
//			}
//			var date:Date = DateFormatter.parseDateString(formattedDateString);
//			if (date && parseAsUniversalTime)
//				date.setTime( date.getTime() - date.getTimezoneOffset() * _timezoneMultiplier );
//			return date;
//		}
		
//		/**
//		 * This will generate a date string from a Number or a Date object using the specified date format.
//		 * @param value The Date object or date string to format.
//		 * @param formatString The format of the date string to be generated.
//		 * @param formatAsUniversalTime If set to true, the date string will be generated using universal time.
//		 *        If set to false, the timezone of the user's computer will be used.
//		 * @return The resulting formatted date string.
//		 * 
//		 * @see mx.formatters::DateFormatter#formatString
//		 * @see Date
//		 */
//		public static function formatDate(value:Object, formatString:String = null, formatAsUniversalTime:Boolean = true):String
//		{
//			var date:Date = value as Date;
//			if (!date || formatAsUniversalTime)
//				date = new Date(value);
//			if (formatAsUniversalTime)
//				date.setTime( date.getTime() + date.getTimezoneOffset() * _timezoneMultiplier );
//			
//			_dateFormatter.formatString = formatString;
//			return _dateFormatter.format(date);
//		}
		
//		/**
//		 * This is the DateFormatter used by parseDate() and formatDate().
//		 */
//		private static const _dateFormatter:DateFormatter = new CustomDateFormatter();
		/**
		 * The number of milliseconds in one minute.
		 */
		private static const _timezoneMultiplier:Number = 60000;
		
		/**
		 * This compares two dynamic objects or primitive values and is much faster than ObjectUtil.compare().
		 * Does not check for circular refrences.
		 * @param a First dynamic object or primitive value.
		 * @param b Second dynamic object or primitive value.
		 * @return A value of zero if the two objects are equal, nonzero if not equal.
		 */
		public static function compare(a:Object, b:Object):int
		{
			var c:int;
			if (a === b)
				return 0;
			if (a == null)
				return 1;
			if (b == null)
				return -1;
			var typeA:String = typeof(a);
			var typeB:String = typeof(b);
			if (typeA != typeB)
				return ObjectUtil.stringCompare(typeA, typeB);
			if (typeA == 'boolean')
				return ObjectUtil.numericCompare(Number(a), Number(b));
			if (typeA == 'number')
				return ObjectUtil.numericCompare(a as Number, b as Number);
			if (typeA == 'string')
				return ObjectUtil.stringCompare(a as String, b as String);
			if (typeA != 'object')
				return 1;
			if (a is Date && b is Date)
				return ObjectUtil.dateCompare(a as Date, b as Date);
			if ((a is Array && b is Array) || (a is Vector && b is Vector))
			{
				var an:int = a.length;
				var bn:int = b.length;
				if (an < bn)
					return -1;
				if (an > bn)
					return 1;
				for (var i:int = 0; i < an; i++)
				{
					c = compare(a[i], b[i]);
					if (c != 0)
						return c;
				}
				return 0;
			}
			
			var qna:String = getQualifiedClassName(a);
			var qnb:String = getQualifiedClassName(b);
			
			if (qna != qnb)
				return ObjectUtil.stringCompare(qna, qnb);
			
			var p:String;
			
			// test if objects are dynamic
			try
			{
				a[''];
				b[''];
			}
			catch (e:Error)
			{
				return 1; // not dynamic objects
			}
			
			// if there are properties in a not found in b, return -1
			for (p in a)
			{
				if (!b.hasOwnProperty(p))
					return -1;
			}
			for (p in b)
			{
				// if there are properties in b not found in a, return 1
				if (!a.hasOwnProperty(p))
					return 1;
				
				c = compare(a[p], b[p]);
				if (c != 0)
					return c;
			}
			
			return 0;
		}
		
		private static function testCompare_generate(base:Object, depth:int):Object
		{
			for (var i:int = 0; i < 10; i++)
			{
				var child:Object = depth > 0 ? {} : Math.random();
				base[Math.random()] = child;
				if (depth > 0)
					testCompare_generate(child, depth - 1);
			}
			return base;
		}
		
//		//WeaveAPI.StageUtils.callLater(null, testCompare);
//		private static function testCompare():void
//		{
//			var i:int;
//			var orig:Object = testCompare_generate({}, 2);
//			var o1:Object = ObjectUtil.copy(orig);
//			var o2:Object = ObjectUtil.copy(o1);
//			
//			trace(ObjectUtil.toString(o1));
//			
//			DebugTimer.begin();
//			for (i = 0; i < 100; i++)
//				if (ObjectUtil.compare(o1,o2) != 0)
//					throw "ObjectUtil.compare fail";
//			DebugTimer.lap('ObjectUtil.compare');
//			for (i = 0; i < 100; i++)
//				if (compare(o1,o2) != 0)
//					throw "StandardLib.compareDynamicObjects fail";
//			DebugTimer.end('StandardLib.compareDynamicObjects');
//		}
		
//		/**
//		 * Binary to Ascii (Base64)
//		 * @param input Binary data
//		 * @return Base64-encoded data
//		 */
//		public static function btoa(input:ByteArray):String
//		{
//			return FlasCC.call(weave.flascc.btoa, input);
//		}
		
//		/**
//		 * Ascii (Base64) to Binary
//		 * @param input Base64-encoded data
//		 * @return Decoded binary data
//		 */
//		public static function atob(input:String):ByteArray
//		{
//			return FlasCC.call(weave.flascc.atob, input);
//		}
		
		/**
		 * @see https://github.com/bestiejs/punycode.js
		 */
		internal static function ucs2encode(value:uint):String
		{
			var output:String = '';
			if (value > 0xFFFF)
			{
				value -= 0x10000;
				output += String.fromCharCode(value >>> 10 & 0x3FF | 0xD800);
				value = 0xDC00 | value & 0x3FF;
			}
			return output + String.fromCharCode(value);
		}
		
		[Deprecated(replacement="compare")] public static function arrayCompare(a:Object, b:Object):int { return compare(a,b); }
		[Deprecated(replacement="compare")] public static function compareDynamicObjects(a:Object, b:Object):int { return compare(a,b); }
	}
}
