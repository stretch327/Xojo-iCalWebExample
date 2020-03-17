#tag Class
Protected Class Calendar
	#tag Method, Flags = &h0
		Sub AddEvent(CE as CalendarEvent)
		  events.Append CE
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AddEvent(Summary as String, StartDate as Date, EndDate as Date, UID as String = "")
		  events.Append new CalendarEvent(Summary, StartDate, EndDate, UID)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Render() As String
		  Dim sa() As String
		  sa.Append "BEGIN:VCALENDAR"
		  sa.Append "VERSION:2.0"
		  sa.Append "PRODID:-//" + name + "//NONSGML v1.0//" + Uppercase(languageCode)
		  sa.Append "DESCRIPTION:" + Description
		  sa.Append "REFRESH-INTERVAL;VALUE=DURATION:PT" + str(RefreshMinutes, "0") + "M"
		  sa.Append "X-WR-CALNAME:" + Description
		  
		  // Chose UTC because it's so easy to change Xojo dates to that and then there's no ambiguity
		  sa.Append "X-WR-TIMEZONE:" + Timezone
		  
		  For i As Integer = 0 To UBound(events)
		    sa.append events(i).render()
		  Next i
		  
		  sa.Append "END:VCALENDAR"
		  
		  Return join(sa, EndOfLine.Windows) //Line endings have to be CRLF
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0
		Description As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private Events() As CalendarEvent
	#tag EndProperty

	#tag Property, Flags = &h0
		LanguageCode As String = "EN"
	#tag EndProperty

	#tag Property, Flags = &h0
		Name As String = "Untitled"
	#tag EndProperty

	#tag Property, Flags = &h0
		RefreshMinutes As Integer = 15
	#tag EndProperty

	#tag Property, Flags = &h0
		Timezone As String = "UTC"
	#tag EndProperty


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
		#tag ViewProperty
			Name="Description"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="LanguageCode"
			Visible=false
			Group="Behavior"
			InitialValue="EN"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="RefreshMinutes"
			Visible=false
			Group="Behavior"
			InitialValue="15"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Timezone"
			Visible=false
			Group="Behavior"
			InitialValue="UTC"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
