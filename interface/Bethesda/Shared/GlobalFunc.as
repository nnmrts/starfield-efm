package Shared
{
   import Shared.AS3.Data.BSUIDataManager;
   import Shared.AS3.Events.CustomEvent;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.FrameLabel;
   import flash.display.MovieClip;
   import flash.display.Shape;
   import flash.display.Stage;
   import flash.events.Event;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.geom.Vector3D;
   import flash.system.fscommand;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import flash.text.TextFormatAlign;
   import flash.text.TextLineMetrics;
   import flash.utils.describeType;
   import flash.utils.getDefinitionByName;
   import flash.utils.getQualifiedClassName;
   import scaleform.gfx.Extensions;
   
   public class GlobalFunc
   {
      public static const SELECTED_RECT_ALPHA:Number = 1;
      
      public static const DIMMED_ALPHA:Number = 0.65;
      
      public static const HOLD_BUTTON_DELAY_DEFAULT:uint = 200;
      
      protected static const CLOSE_ENOUGH_EPSILON:Number = 0.001;
      
      public static const PLAY_FOCUS_SOUND:String = "GlobalFunc_PlayFocusSound";
      
      public static const START_GAME_RENDER:String = "GlobalFunc_StartGameRender";
      
      public static const PLAY_MENU_SOUND:String = "GlobalFunc_PlayMenuSound";
      
      public static const USER_EVENT:String = "GlobalFunc_UserEvent";
      
      public static const CLOSE_MENU:String = "GlobalFunc_CloseMenu";
      
      public static const CLOSE_ALL_MENUS:String = "GlobalFunc_CloseAllMenus";
      
      public static const FOCUS_SOUND:String = "UIMenuGeneralFocus";
      
      public static const OK_SOUND:String = "UIMenuGeneralOK";
      
      public static const CANCEL_SOUND:String = "UIMenuGeneralCancel";
      
      public static const COLUMN_SWITCH_SOUND:String = "UIMenuGeneralColumn";
      
      public static const TAB_SWITCH_SOUND:String = "UIMenuGeneralTab";
      
      public static const LONG_PRESS_START_SOUND:String = "UIMenuGeneralLongPressStart";
      
      public static const LONG_PRESS_COMPLETE_SOUND:String = "UIMenuGeneralLongPressComplete";
      
      public static const LONG_PRESS_ABORT_SOUND:String = "UIMenuGeneralLongPressAbort";
      
      protected static const MINUTES_PER_DAY:int = 1440;
      
      protected static const MINUTES_PER_HOUR:int = 60;
      
      public static const NameToTextMap:Object = {
         "Xenon_A":"A",
         "Xenon_B":"B",
         "Xenon_X":"C",
         "Xenon_Y":"D",
         "Xenon_Select":"E",
         "Xenon_LS":"F",
         "Xenon_L1":"G",
         "Xenon_L3":"H",
         "Xenon_L2":"I",
         "Xenon_L2R2":"J",
         "Xenon_RS":"K",
         "Xenon_R1":"L",
         "Xenon_R3":"M",
         "Xenon_R2":"N",
         "Xenon_Start":"O",
         "Xenon_L1R1":"1",
         "_Positive":"P",
         "_Negative":"Q",
         "_Question":"R",
         "_Neutral":"S",
         "Left":"T",
         "Right":"U",
         "Down":"V",
         "Up":"W",
         "Xenon_R2_Alt":"X",
         "Xenon_L2_Alt":"Y",
         "PSN_A":"a",
         "PSN_Y":"b",
         "PSN_X":"c",
         "PSN_B":"d",
         "PSN_Select":"z",
         "PSN_L3":"f",
         "PSN_L1":"g",
         "PSN_L1R1":"h",
         "PSN_LS":"i",
         "PSN_L2":"j",
         "PSN_L2R2":"k",
         "PSN_R3":"l",
         "PSN_R1":"m",
         "PSN_RS":"n",
         "PSN_R2":"o",
         "PSN_Start":"p",
         "DPad_LR":"q",
         "DPad_UD":"r",
         "DPad_All":"s",
         "DPad_Left":"t",
         "DPad_Right":"u",
         "DPad_Down":"v",
         "DPad_Up":"w",
         "PSN_R2_Alt":"x",
         "PSN_L2_Alt":"y",
         "Xenon_L1Xenon_R1":"1",
         "Xenon_L2Xenon_R2":"J",
         "PSN_L1PSN_R1":"h",
         "PSN_L2PSN_R2":"k",
         "DPad_LeftDPad_Right":"q",
         "DPad_DownDPad_Up":"r",
         "DPad_DownDPad_LeftDPad_RightDPad_Up":"s",
         "LeftRight":"q",
         "DownUp":"r",
         "DownLeftRightUp":"s",
         "PCLeft":"←",
         "PCRight":"→",
         "PCDown":"↓",
         "PCUp":"↑",
         "PCLeftRight":"← →",
         "PCDownUp":"↑ ↓",
         "PCDownLeftRightUp":"↑ ↓ ← →",
         "PCMouseWheelDownMouseWheelUp":"Mousewheel"
      };
      
      private static const MetersInLightSeconds:Number = 299792458;
      
      private static const MetersInAU:Number = 149597870700;
      
      private static const MaxMeterDisplay:Number = 10000;
      
      private static const MaxKilometerDisplay:Number = 30000 * 1000;
      
      private static const MaxLightSecondsDisplay:Number = 50000 * MetersInLightSeconds;
      
      private static const MeterPrecision:uint = 0;
      
      private static const KilometerPrecision:uint = 0;
      
      private static const LightSecondPrecision:uint = 1;
      
      private static const AUPrecision:uint = 2;
      
      public function GlobalFunc()
      {
         super();
      }
      
      public static function Lerp(start:Number, end:Number, fraction:Number) : Number
      {
         return start + fraction * (end - start);
      }
      
      public static function VectorLerp(startVec:Vector3D, endVec:Vector3D, fraction:Number) : Vector3D
      {
         var diff:Vector3D = endVec.subtract(startVec);
         diff.scaleBy(fraction);
         return startVec.add(diff);
      }
      
      public static function MapLinearlyToRange(rangeStart:Number, rangeEnd:Number, inputValue:Number, inputMin:Number, inputMax:Number, clampResult:Boolean) : Number
      {
         var mappedFraction:Number = (inputValue - inputMin) / (inputMax - inputMin);
         var result:Number = Lerp(rangeStart, rangeEnd, mappedFraction);
         if(clampResult)
         {
            if(rangeStart < rangeEnd)
            {
               result = Clamp(result, rangeStart, rangeEnd);
            }
            else
            {
               result = Clamp(result, rangeEnd, rangeStart);
            }
         }
         return result;
      }
      
      public static function Clamp(value:Number, min:Number, max:Number) : Number
      {
         var result:Number = value;
         if(value < min)
         {
            result = min;
         }
         else if(value > max)
         {
            result = max;
         }
         return result;
      }
      
      public static function PadNumber(value:Number, width:uint) : String
      {
         var result:String = "" + value;
         while(result.length < width)
         {
            result = "0" + result;
         }
         return result;
      }
      
      public static function FormatTimeString(timeInSeconds:Number, showHours:Boolean = false, showMinutes:Boolean = false, showSeconds:Boolean = false) : String
      {
         var remainingSeconds:* = 0;
         var roundedTime:Number = Math.round(timeInSeconds);
         var hours:int = Math.floor(roundedTime / 3600);
         remainingSeconds = roundedTime % 3600;
         var minutes:int = Math.floor(remainingSeconds / 60);
         remainingSeconds = roundedTime % 60;
         var seconds:int = Math.round(remainingSeconds);
         var hasPrevious:Boolean = false;
         var timeString:* = "";
         if(showHours || hours > 0)
         {
            timeString = PadNumber(hours,2);
            hasPrevious = true;
         }
         if(showMinutes || (hours > 0 || minutes > 0))
         {
            if(hasPrevious)
            {
               timeString += ":";
            }
            else
            {
               hasPrevious = true;
            }
            timeString += PadNumber(minutes,2);
         }
         if(showSeconds || (hours > 0 || minutes > 0 || seconds > 0))
         {
            if(hasPrevious)
            {
               timeString += ":";
            }
            timeString += PadNumber(seconds,2);
         }
         return timeString;
      }
      
      public static function RoundDecimal(value:Number, precision:Number) : Number
      {
         var factor:Number = Math.pow(10,precision);
         return Math.round(factor * value) / factor;
      }
      
      public static function RoundDecimalToFixedString(value:Number, precision:Number) : String
      {
         var roundedValue:Number = RoundDecimal(value,precision);
         return roundedValue.toFixed(precision);
      }
      
      public static function CloseToNumber(value1:Number, value2:Number, epsilon:Number = 0.001) : Boolean
      {
         return Math.abs(value1 - value2) < epsilon;
      }
      
      public static function MaintainTextFormat() : *
      {
         TextField.prototype.SetText = function(text:String, isHTML:Boolean = false, forceUpper:Boolean = false):*
         {
            var letterSpacing:Number = NaN;
            var useKerning:Boolean = false;
            if(!text || text == "")
            {
               text = " ";
            }
            if(forceUpper && text.charAt(0) != "$")
            {
               text = text.toUpperCase();
            }
            var textFormat:TextFormat = this.getTextFormat();
            if(isHTML)
            {
               letterSpacing = Number(textFormat.letterSpacing);
               useKerning = Boolean(textFormat.kerning);
               this.htmlText = text;
               textFormat = this.getTextFormat();
               textFormat.letterSpacing = letterSpacing;
               textFormat.kerning = useKerning;
               this.setTextFormat(textFormat);
               this.htmlText = text;
            }
            else
            {
               this.text = text;
               this.setTextFormat(textFormat);
               this.text = text;
            }
         };
      }
      
      public static function FormatNumberToString(value:Number, precision:uint = 0, useScientific:Boolean = false) : String
      {
         var result:String = null;
         var factor:Number = NaN;
         var roundedValue:int = 0;
         var hasDecimal:Boolean = false;
         var decimalCount:* = undefined;
         var valueString:String = null;
         var charIndex:* = undefined;
         var integerPart:String = null;
         var decimalPart:String = null;
         var lastNonZeroIndex:int = 0;
         var finalDecimalPart:String = null;
         var finalResult:String = null;
         var decimalIndex:* = undefined;
         if(useScientific)
         {
            if(precision == 0)
            {
               result = int(Math.round(value)).toString();
            }
            else if(value == 0)
            {
               result = "0";
            }
            else
            {
               factor = Math.pow(10,precision);
               roundedValue = int(Math.round(value * factor));
               if(roundedValue == 0)
               {
                  result = "0";
               }
               else
               {
                  hasDecimal = false;
                  decimalCount = 0;
                  valueString = value.toString();
                  charIndex = 0;
                  while(charIndex < valueString.length)
                  {
                     switch(valueString.charAt(charIndex))
                     {
                        case ".":
                           hasDecimal = true;
                           break;
                        case "0":
                           if(hasDecimal)
                           {
                              decimalCount++;
                           }
                           break;
                        default:
                           charIndex = valueString.length;
                           break;
                     }
                     charIndex++;
                  }
                  result = roundedValue.toString();
                  decimalIndex = 0;
                  while(decimalIndex < decimalCount)
                  {
                     result = "0" + result;
                     decimalIndex++;
                  }
                  lastNonZeroIndex = result.length - precision;
                  integerPart = result.substring(0,lastNonZeroIndex);
                  decimalPart = result.substring(lastNonZeroIndex,result.length);
                  lastNonZeroIndex = decimalPart.length - 1;
                  while(lastNonZeroIndex >= 0)
                  {
                     if(decimalPart.charAt(lastNonZeroIndex) != "0")
                     {
                        break;
                     }
                     lastNonZeroIndex--;
                  }
                  finalDecimalPart = decimalPart.substring(0,lastNonZeroIndex + 1);
                  if(finalDecimalPart.length > 0)
                  {
                     result = integerPart + "." + finalDecimalPart;
                  }
                  else
                  {
                     result = integerPart;
                  }
               }
            }
         }
         else
         {
            result = value.toString();
            decimalIndex = result.indexOf(".");
            if(decimalIndex > -1)
            {
               if(precision)
               {
                  result = result.substring(0,Math.min(decimalIndex + precision + 1,result.length));
               }
               else
               {
                  result = result.substring(0,decimalIndex);
               }
            }
         }
         return result;
      }
      
      public static function ClearClipOfChildren(container:DisplayObjectContainer) : void
      {
         while(container.numChildren > 0)
         {
            container.removeChildAt(0);
         }
      }
      
      public static function FormatDistanceToString(distance:Number) : String
      {
         var result:* = "";
         if(distance < MaxMeterDisplay)
         {
            result = FormatNumberToString(distance,MeterPrecision) + " M";
         }
         else if(distance < MaxKilometerDisplay)
         {
            result = FormatNumberToString(distance / 1000,KilometerPrecision) + " KM";
         }
         else if(distance < MaxLightSecondsDisplay)
         {
            result = FormatNumberToString(distance / MetersInLightSeconds,LightSecondPrecision) + " LS";
         }
         else
         {
            result = FormatNumberToString(distance / MetersInAU,AUPrecision) + " AU";
         }
         return result;
      }
      
      public static function SetText(textField:TextField, text:String, isHTML:Boolean = false, forceUpper:Boolean = false, maxChars:int = 0, shrinkToFit:Boolean = false, padding:uint = 0, substitutions:Array = null, leading:uint = 0, maxLines:uint = 0) : *
      {
         var letterSpacing:Number = NaN;
         var useKerning:Boolean = false;
         var charIndex:* = undefined;
         var charStart:* = 0;
         var charBounds:* = undefined;
         var originalX:Number = NaN;
         var originalWidth:Number = NaN;
         var finalWidth:Number = NaN;
         if(!text || text == "")
         {
            text = " ";
         }
         if(forceUpper && text.charAt(0) != "$")
         {
            text = text.toUpperCase();
         }
         var textFormat:TextFormat = textField.getTextFormat();
         if(isHTML)
         {
            letterSpacing = Number(textFormat.letterSpacing);
            useKerning = Boolean(textFormat.kerning);
            textField.htmlText = text;
            if(substitutions != null)
            {
               textField.htmlText = DoSubstitutions(textField.htmlText,substitutions);
            }
            textFormat = textField.getTextFormat();
            textFormat.letterSpacing = letterSpacing;
            textFormat.kerning = useKerning;
            if(leading != 0)
            {
               textFormat.leading = leading;
            }
            textField.setTextFormat(textFormat);
         }
         else
         {
            textField.text = text;
            if(substitutions != null)
            {
               textField.text = DoSubstitutions(textField.text,substitutions);
            }
         }
         if(maxLines > 0 && textField.numLines > maxLines)
         {
            textField.text = textField.text.slice(0,textField.getLineOffset(maxLines) - 1) + "…";
         }
         if(maxChars > 0)
         {
            if(textField.text.length > maxChars)
            {
               textField.text = textField.text.slice(0,maxChars - 1) + "…";
            }
            else if(textField.textWidth > textField.width && textField.wordWrap === false)
            {
               charIndex = textField.length - 1;
               charStart = 0;
               while(charStart < textField.text.length)
               {
                  charBounds = textField.getCharBoundaries(charStart);
                  if(charBounds.right > textField.x + textField.width)
                  {
                     charIndex = charStart;
                     break;
                  }
                  charStart++;
               }
               textField.text = textField.text.slice(0,charIndex - 2) + "…";
            }
         }
         if(shrinkToFit)
         {
            originalX = textField.x;
            originalWidth = textField.width;
            finalWidth = textField.textWidth + 2 * padding;
            switch(textFormat.align)
            {
               case TextFormatAlign.RIGHT:
                  textField.x += originalWidth - (finalWidth + padding);
                  break;
               case TextFormatAlign.CENTER:
                  textField.x += (originalWidth - finalWidth) / 2;
            }
            textField.width = finalWidth;
            textField.height = textField.textHeight;
         }
      }
      
      public static function SetTwoLineText(textField:TextField, text:String, maxCharsPerLine:int, forceUpper:Boolean = false) : *
      {
         var charIndex:int = 0;
         var charStart:* = undefined;
         var finalMaxChars:int = maxCharsPerLine;
         if(text.length > maxCharsPerLine)
         {
            charIndex = 0;
            while(charIndex <= maxCharsPerLine)
            {
               if(text.charAt(charIndex) == " " || text.charAt(charIndex) == "-")
               {
                  finalMaxChars = charIndex - 1;
               }
               charIndex++;
            }
            charStart = finalMaxChars + maxCharsPerLine;
            GlobalFunc.SetText(textField,text,false,forceUpper,charStart);
         }
         else
         {
            GlobalFunc.SetText(textField,text,false,forceUpper);
         }
      }
      
      public static function TruncateSingleLineText(textField:TextField) : *
      {
         var charIndex:int = 0;
         if(textField.text.length > 3)
         {
            charIndex = textField.getCharIndexAtPoint(textField.width,0);
            if(charIndex > 0)
            {
               textField.replaceText(charIndex - 1,textField.length,"…");
            }
         }
      }
      
      public static function SetTruncatedMultilineText(textField:TextField, text:String, forceUpper:Boolean = false) : *
      {
         var finalText:* = null;
         var charIndex:int = 0;
         var charStart:* = undefined;
         var lineMetrics:TextLineMetrics = textField.getLineMetrics(0);
         var maxLines:int = textField.height / lineMetrics.height;
         textField.text = "W";
         var maxCharsPerLine:int = textField.width / textField.textWidth;
         GlobalFunc.SetText(textField,text,false,forceUpper);
         var numLines:int = Math.min(maxLines,textField.numLines);
         if(textField.numLines > maxLines)
         {
            finalText = text;
            charIndex = textField.getLineOffset(maxLines - 1);
            charStart = charIndex + maxCharsPerLine - 1;
            if(finalText.charAt(charStart - 1) == " ")
            {
               charStart--;
            }
            finalText = finalText.substr(0,charStart) + "…";
            GlobalFunc.SetText(textField,finalText,false,forceUpper);
         }
      }
      
      public static function DoSubstitutions(text:String, substitutions:Array) : String
      {
         var regex:RegExp = null;
         var result:String = text;
         var index:int = 0;
         while(index < substitutions.length)
         {
            regex = new RegExp("{[" + index + "]}","g");
            result = result.replace(regex,substitutions[index]);
            index++;
         }
         return result;
      }
      
      public static function LockToSafeRect(displayObject:DisplayObject, position:String, offsetX:Number = 0, offsetY:Number = 0, useBounds:Boolean = false) : *
      {
         var error:Error = null;
         if(!displayObject)
         {
            error = new Error();
            trace("GlobalFunc::LockToSafeRect -- called with a null or undefined display object\n" + error.getStackTrace());
            return;
         }
         var visibleRect:Rectangle = Extensions.visibleRect;
         var topLeft:Point = new Point(visibleRect.x + offsetX,visibleRect.y + offsetY);
         var bottomRight:Point = new Point(visibleRect.x + visibleRect.width - offsetX,visibleRect.y + visibleRect.height - offsetY);
         var localTopLeft:Point = displayObject.parent.globalToLocal(topLeft);
         var localBottomRight:Point = displayObject.parent.globalToLocal(bottomRight);
         var localCenter:Point = Point.interpolate(localTopLeft,localBottomRight,0.5);
         var bounds:Rectangle = displayObject.getBounds(displayObject.parent);
         if(position == "T" || position == "TL" || position == "TR" || position == "TC")
         {
            if(useBounds)
            {
               displayObject.y = localTopLeft.y + displayObject.y - bounds.y;
            }
            else
            {
               displayObject.y = localTopLeft.y;
            }
         }
         if(position == "CR" || position == "CC" || position == "CL")
         {
            if(useBounds)
            {
               displayObject.y = localCenter.y + displayObject.y - bounds.y - bounds.height / 2;
            }
            else
            {
               displayObject.y = localCenter.y;
            }
         }
         if(position == "B" || position == "BL" || position == "BR" || position == "BC")
         {
            if(useBounds)
            {
               displayObject.y = localBottomRight.y - (bounds.height + bounds.y - displayObject.y);
            }
            else
            {
               displayObject.y = localBottomRight.y;
            }
         }
         if(position == "L" || position == "TL" || position == "BL" || position == "CL")
         {
            if(useBounds)
            {
               displayObject.x = localTopLeft.x + displayObject.x - bounds.x;
            }
            else
            {
               displayObject.x = localTopLeft.x;
            }
         }
         if(position == "TC" || position == "CC" || position == "BC")
         {
            if(useBounds)
            {
               displayObject.x = localCenter.x + displayObject.x - bounds.x - bounds.width / 2;
            }
            else
            {
               displayObject.x = localCenter.x;
            }
         }
         if(position == "R" || position == "TR" || position == "BR" || position == "CR")
         {
            if(useBounds)
            {
               displayObject.x = localBottomRight.x - (bounds.width + bounds.x - displayObject.x);
            }
            else
            {
               displayObject.x = localBottomRight.x;
            }
         }
      }
      
      public static function AddMovieExploreFunctions() : *
      {
         MovieClip.prototype.getMovieClips = function():Array
         {
            var key:* = undefined;
            var result:Array = new Array();
            for(key in this)
            {
               if(this[key] is MovieClip && this[key] != this)
               {
                  result.push(this[key]);
               }
            }
            return result;
         };
         MovieClip.prototype.showMovieClips = function():*
         {
            var key:* = undefined;
            for(key in this)
            {
               if(this[key] is MovieClip && this[key] != this)
               {
                  trace(this[key]);
                  this[key].showMovieClips();
               }
            }
         };
      }
      
      public static function InspectObject(object:Object, recursive:Boolean = false, includeProperties:Boolean = false) : void
      {
         var className:String = getQualifiedClassName(object);
         trace("Inspecting object with type " + className);
         trace("{");
         InspectObjectHelper(object,new Array(),recursive,includeProperties);
         trace("}");
      }
      
      private static function InspectObjectHelper(object:Object, seenObjects:Array, recursive:Boolean, includeProperties:Boolean, indent:String = "\t") : void
      {
         var typeDef:XML;
         var member:XML = null;
         var constMember:XML = null;
         var id:String = null;
         var prop:XML = null;
         var propName:String = null;
         var propValue:Object = null;
         var memberName:String = null;
         var memberValue:Object = null;
         var constMemberName:String = null;
         var constMemberValue:Object = null;
         var value:Object = null;
         var subid:String = null;
         var subvalue:Object = null;
         var aObject:Object = object;
         var aSeenObjects:Array = seenObjects;
         var abRecursive:Boolean = recursive;
         var abIncludeProperties:Boolean = includeProperties;
         var astrIndent:String = indent;
         if(aSeenObjects.indexOf(aObject) != -1)
         {
            return;
         }
         aSeenObjects.push(aObject);
         typeDef = describeType(aObject);
         if(abIncludeProperties)
         {
            for each(prop in typeDef.accessor.(@access == "readwrite" || @access == "readonly"))
            {
               propName = prop.@name;
               propValue = aObject[prop.@name];
               trace(astrIndent + propName + " = " + propValue);
               if(abRecursive)
               {
                  InspectObjectHelper(propValue,aSeenObjects,abRecursive,abIncludeProperties,astrIndent + "\t");
               }
            }
         }
         for each(member in typeDef.variable)
         {
            memberName = member.@name;
            memberValue = aObject[memberName];
            trace(astrIndent + memberName + " = " + memberValue);
            if(abRecursive)
            {
               InspectObjectHelper(memberValue,aSeenObjects,abRecursive,abIncludeProperties,astrIndent + "\t");
            }
         }
         for each(constMember in typeDef.constant)
         {
            constMemberName = constMember.@name;
            constMemberValue = aObject[constMemberName];
            trace(astrIndent + constMemberName + " = " + constMemberValue + " --const");
            if(abRecursive)
            {
               InspectObjectHelper(constMemberValue,aSeenObjects,abRecursive,abIncludeProperties,astrIndent + "\t");
            }
         }
         for(id in aObject)
         {
            value = aObject[id];
            trace(astrIndent + id + " = " + value);
            if(abRecursive)
            {
               InspectObjectHelper(value,aSeenObjects,abRecursive,abIncludeProperties,astrIndent + "\t");
            }
            else
            {
               for(subid in value)
               {
                  subvalue = value[subid];
                  trace(astrIndent + "\t" + subid + " = " + subvalue);
               }
            }
         }
      }
      
      public static function GetFullClipPath(displayObject:DisplayObject) : String
      {
         var currentObject:DisplayObject = displayObject;
         var path:String = "";
         if(currentObject == null)
         {
            path = "null";
         }
         else
         {
            path = currentObject.name;
            currentObject = currentObject.parent;
            while(currentObject != null && !(currentObject is Stage))
            {
               path = currentObject.name + "." + path;
               currentObject = currentObject.parent;
            }
         }
         return path;
      }
      
      public static function FrameLabelExists(movieClip:MovieClip, label:String) : Boolean
      {
         var frameLabel:FrameLabel = null;
         for each(frameLabel in movieClip.currentLabels)
         {
            if(frameLabel.name == label)
            {
               return true;
            }
         }
         return false;
      }
      
      public static function AddReverseFunctions() : *
      {
         MovieClip.prototype.PlayReverseCallback = function(event:Event):*
         {
            if(event.currentTarget.currentFrame > 1)
            {
               event.currentTarget.gotoAndStop(event.currentTarget.currentFrame - 1);
            }
            else
            {
               event.currentTarget.removeEventListener(Event.ENTER_FRAME,event.currentTarget.PlayReverseCallback);
            }
         };
         MovieClip.prototype.PlayReverse = function():*
         {
            if(this.currentFrame > 1)
            {
               this.gotoAndStop(this.currentFrame - 1);
               this.addEventListener(Event.ENTER_FRAME,this.PlayReverseCallback);
            }
            else
            {
               this.gotoAndStop(1);
            }
         };
         MovieClip.prototype.PlayForward = function(frameLabel:String):*
         {
            delete this.onEnterFrame;
            this.gotoAndPlay(frameLabel);
         };
         MovieClip.prototype.PlayForward = function(frameNumber:Number):*
         {
            delete this.onEnterFrame;
            this.gotoAndPlay(frameNumber);
         };
      }
      
      public static function PlayMenuSound(soundID:String, rtpcName:String = "", rtpcValue:Number = 0) : *
      {
         BSUIDataManager.dispatchEvent(new CustomEvent(GlobalFunc.PLAY_MENU_SOUND,{
            "sSoundID":soundID,
            "sRTPCName":rtpcName,
            "fRTPCValue":rtpcValue
         }));
      }
      
      public static function StartGameRender() : *
      {
         BSUIDataManager.dispatchEvent(new Event(GlobalFunc.START_GAME_RENDER));
      }
      
      public static function UserEvent(menuName:String, eventID:String) : *
      {
         BSUIDataManager.dispatchEvent(new CustomEvent(GlobalFunc.USER_EVENT,{
            "menuName":menuName,
            "eventID":eventID
         }));
      }
      
      public static function CloseMenu(menuName:String) : *
      {
         BSUIDataManager.dispatchEvent(new CustomEvent(GlobalFunc.CLOSE_MENU,{"menuName":menuName}));
      }
      
      public static function CloseAllMenus() : *
      {
         BSUIDataManager.dispatchEvent(new Event(GlobalFunc.CLOSE_ALL_MENUS));
      }
      
      public static function StringTrim(text:String) : String
      {
         var trimmedText:String = null;
         var startIndex:Number = 0;
         var endIndex:Number = 0;
         var textLength:Number = text.length;
         while(text.charAt(startIndex) == " " || text.charAt(startIndex) == "\n" || text.charAt(startIndex) == "\r" || text.charAt(startIndex) == "\t")
         {
            startIndex++;
         }
         trimmedText = text.substring(startIndex);
         endIndex = trimmedText.length - 1;
         while(trimmedText.charAt(endIndex) == " " || trimmedText.charAt(endIndex) == "\n" || trimmedText.charAt(endIndex) == "\r" || trimmedText.charAt(endIndex) == "\t")
         {
            endIndex--;
         }
         return trimmedText.substring(0,endIndex + 1);
      }
      
      public static function GetTextFieldFontSize(textField:TextField) : Number
      {
         return GetFontSize(textField.getTextFormat());
      }
      
      public static function GetFontSize(textFormat:TextFormat) : Number
      {
         var defaultSize:Number = 12;
         var fontSize:Object = textFormat.size;
         return fontSize != null ? fontSize as Number : defaultSize;
      }
      
      public static function BSASSERT(condition:Boolean, message:String) : void
      {
         var stackTrace:String = null;
         if(!condition)
         {
            stackTrace = new Error().getStackTrace();
            fscommand("BSASSERT",message + "\nCallstack:\n" + stackTrace);
         }
      }
      
      public static function TraceWarning(message:String) : void
      {
         var stackTrace:String = new Error().getStackTrace();
         trace("WARNING: " + message + stackTrace.substr(stackTrace.indexOf("\n")));
      }
      
      public static function BinarySearchUpperBound(target:*, array:Array, property:String = null) : Object
      {
         var mid:int = 0;
         var midValue:* = undefined;
         var midProperty:* = undefined;
         var low:int = 0;
         var high:int = int(array.length - 1);
         var targetValue:* = target;
         if(property != null && Boolean(target.hasOwnProperty(property)))
         {
            targetValue = target[property];
         }
         while(low <= high)
         {
            mid = (low + high) / 2;
            midProperty = midValue = array[mid];
            if(property != null)
            {
               midProperty = midValue[property];
            }
            if(midProperty < targetValue)
            {
               low = mid + 1;
            }
            else
            {
               if(midProperty <= targetValue)
               {
                  return {
                     "found":true,
                     "index":mid
                  };
               }
               high = mid - 1;
            }
         }
         return {
            "found":false,
            "index":low
         };
      }
      
      public static function CloneObject(object:Object) : Object
      {
         var clone:Object = null;
         var key:* = undefined;
         var className:String = getQualifiedClassName(object);
         var classReference:Class = getDefinitionByName(className) as Class;
         if(className !== "Array" && typeof object != "object")
         {
            clone = object;
         }
         else
         {
            clone = new classReference();
            for(key in object)
            {
               clone[key] = CloneObject(object[key]);
            }
         }
         return clone;
      }
      
      public static function FindObjectWithProperty(propertyName:String, propertyValue:*, array:Array) : Object
      {
         var index:uint = 0;
         var element:* = undefined;
         var length:uint = array.length;
         index = 0;
         while(index < length)
         {
            element = array[index];
            if(element[propertyName] == propertyValue)
            {
               return element;
            }
            index++;
         }
         return null;
      }
      
      public static function FindIndexWithProperty(propertyName:String, propertyValue:*, array:Array) : int
      {
         var index:uint = 0;
         var element:* = undefined;
         var length:uint = array.length;
         index = 0;
         while(index < length)
         {
            element = array[index];
            if(element[propertyName] == propertyValue)
            {
               return index;
            }
            index++;
         }
         return -1;
      }
      
      public static function HasFireForgetEvent(dataObject:Object, eventString:String) : Boolean
      {
         var obj:Object = null;
         var aDataObject:Object = dataObject;
         var asEventString:String = eventString;
         var result:Boolean = false;
         try
         {
            if(aDataObject.aEvents.length > 0)
            {
               for each(obj in aDataObject.aEvents)
               {
                  if(obj.sEventName == asEventString)
                  {
                     result = true;
                     break;
                  }
               }
            }
         }
         catch(e:Error)
         {
            trace(e.getStackTrace() + " The following Fire Forget Event object could not be parsed:");
            GlobalFunc.InspectObject(aDataObject,true);
         }
         return result;
      }
      
      public static function DebugDrawCircle(container:MovieClip, center:Point, color:uint = 16777215, radius:Number = 5) : *
      {
         var circle:Shape = new Shape();
         circle.graphics.beginFill(color,1);
         circle.graphics.lineStyle(2,0);
         circle.graphics.drawCircle(center.x,center.y,radius);
         circle.graphics.endFill();
         container.addChild(circle);
      }
      
      public static function GetQuestTimeRemainingString(minutesRemaining:int) : String
      {
         var result:String = "";
         var remainingMinutes:* = 0;
         var days:Number = Math.floor(minutesRemaining / MINUTES_PER_DAY);
         remainingMinutes = minutesRemaining % MINUTES_PER_DAY;
         var hours:Number = Math.floor(remainingMinutes / MINUTES_PER_HOUR);
         remainingMinutes %= MINUTES_PER_HOUR;
         var minutes:Number = Math.floor(remainingMinutes);
         if(days > 0)
         {
            result = GlobalFunc.PadNumber(days,2) + " " + (days == 1 ? "$$DAY" : "$$DAYS") + " : " + GlobalFunc.PadNumber(hours,2) + " " + (hours == 1 ? "$$HOUR" : "$$HOURS");
         }
         else if(hours >= 2)
         {
            result = GlobalFunc.PadNumber(hours,2) + " " + (hours == 1 ? "$$HOUR" : "$$HOURS");
         }
         else
         {
            result = GlobalFunc.PadNumber(hours,2) + " " + (hours == 1 ? "$$HOUR" : "$$HOURS") + " : " + GlobalFunc.PadNumber(minutes,2) + " " + (minutes == 1 ? "$$MINUTE" : "$$MINUTES");
         }
         return result;
      }
      
      public static function ConvertScreenPercentsToLocalPoint(percentX:Number, percentY:Number, container:DisplayObjectContainer) : Point
      {
         var visibleRect:Rectangle = null;
         var globalX:* = undefined;
         var globalY:* = undefined;
         visibleRect = Extensions.visibleRect;
         globalX = percentX * visibleRect.width + visibleRect.x;
         globalY = (1 - percentY) * visibleRect.height + visibleRect.y;
         var globalPoint:Point = new Point(globalX,globalY);
         return container.globalToLocal(globalPoint);
      }
      
      public static function GetRectangleCenter(rectangle:Rectangle) : Point
      {
         return new Point((rectangle.topLeft.x + rectangle.bottomRight.x) / 2,(rectangle.topLeft.y + rectangle.bottomRight.y) / 2);
      }
   }
}
