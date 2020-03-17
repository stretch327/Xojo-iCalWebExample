#tag Module
Protected Module iCal
	#tag Method, Flags = &h1
		Protected Function EscapeSpecialCharacters(Extends Input as String) As String
		  // https://www.kanzaki.com/docs/ical/text.html
		  // Formal Definition
		  // 
		  // The character sets supported by this revision Of
		  // iCalendar are UTF-8 And US ASCII thereof. The applicability To other
		  // character sets Is For future work. The value type Is defined by the
		  // following notation.
		  // 
		  // Text       = *(TSAFE-CHAR / ":" / DQUOTE / ESCAPED-CHAR)
		  // ; Folded according To description above
		  // 
		  // ESCAPED-CHAR = "\\" / "\;" / "\," / "\N" / "\n")
		  // ; \\ encodes \, \N Or \n encodes newline
		  // ; \; encodes ;, \, encodes ,
		  // TSAFE-CHAR = %x20-21 / %x23-2B / %x2D-39 / %x3C-5B
		  // %x5D-7E / NON-US-ASCII
		  // ; Any character except CTLs Not needed by the current
		  // ; character set, DQUOTE, ";", ":", "\", ","
		  // 
		  // Note: Certain other character sets may require modification Of the
		  // above definitions, but this Is beyond the scope Of this document.
		  // Description
		  // 
		  // If the Property permits, multiple "text" values are specified by a COMMA character (US-ASCII decimal 44) separated list Of values.
		  // 
		  // The language In which the Text Is represented can be controlled by the "LANGUAGE" Property parameter.
		  // 
		  // An intentional formatted Text line Break MUST only be included In a "TEXT" Property value by representing the line Break With the character sequence Of BACKSLASH (US-ASCII decimal 92), followed by a LATIN SMALL LETTER N (US-ASCII decimal 110) Or a LATIN CAPITAL LETTER N (US-ASCII decimal 78), that Is "\n" Or "\N".
		  // 
		  // The "TEXT" Property values may also contain special characters that are used To signify delimiters, such As a COMMA character For lists Of values Or a SEMICOLON character For structured values. In order To support the inclusion Of these special characters In "TEXT" Property values, they MUST be escaped With a BACKSLASH character. A BACKSLASH character (US-ASCII decimal 92) In a "TEXT" Property value MUST be escaped With another BACKSLASH character. A COMMA character In a "TEXT" Property value MUST be escaped With a BACKSLASH character (US-ASCII decimal 92). A SEMICOLON character In a "TEXT" Property value MUST be escaped With a BACKSLASH character (US-ASCII decimal 92). However, a COLON character In a "TEXT" Property value SHALL Not be escaped With a BACKSLASH character.Example: A multiple line value Of:
		  // 
		  // Project XYZ Final Review Conference Room - 3B Come Prepared.
		  // 
		  // would be represented As:
		  // 
		  // Project XYZ Final Review\nConference Room - 3B\nCome Prepared.
		  
		  Dim output As String = Input
		  output = output.ReplaceAll("\", "\\")
		  output = output.ReplaceAll(",", "\,")
		  output = output.ReplaceAll(";", "\;")
		  output = output.ReplaceAll(EndOfLine,"\n")
		  return output
		End Function
	#tag EndMethod


	#tag ViewBehavior
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Module
#tag EndModule
