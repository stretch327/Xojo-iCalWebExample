#tag Class
Protected Class CalendarEvent
	#tag Method, Flags = &h0
		Sub Constructor(Summary as String, StartDate as Date, EndDate as Date, UID as String = "")
		  self.summary = summary
		  Self.startdate = startdate
		  Self.enddate = enddate
		  
		  If UID = "" Then
		    UID = EncodeHex(crypto.GenerateRandomBytes(64))
		  End If
		  
		  Self.mUID = UID
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function ConvertDate(d as date, includeTime as Boolean = False) As String
		  Dim sa() As String
		  sa.Append str(d.Year, "0")
		  sa.Append str(d.Month, "00")
		  sa.Append str(d.Day, "00")
		  
		  If includeTime Then
		    sa.Append "T"
		    sa.Append str(d.Hour, "00")
		    sa.Append str(d.Minute, "00")
		    sa.Append str(d.Second, "00")
		    sa.Append "Z"
		  End If
		  
		  return join(sa,"")
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Render() As String
		  Dim sa() As String
		  
		  Dim now As New Date
		  
		  sa.Append "BEGIN:VEVENT"
		  sa.Append "SUMMARY:" + Summary
		  sa.Append "UID:" + UID
		  sa.Append "DTSTAMP:" + ConvertDate(now, True)
		  sa.Append "DTSTART;VALUE=DATE:" + ConvertDate(StartDate)
		  sa.Append "DTEND;VALUE=DATE:" + ConvertDate(EndDate)
		  sa.Append "TRANSP:TRANSPARENT"
		  sa.Append "END:VEVENT"
		  
		  return join(sa,EndOfLine)
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0
		EndDate As Date
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mUID As String
	#tag EndProperty

	#tag Property, Flags = &h0
		StartDate As Date
	#tag EndProperty

	#tag Property, Flags = &h0
		Summary As String
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return mUID
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mUID = value
			End Set
		#tag EndSetter
		UID As String
	#tag EndComputedProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Summary"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="UID"
			Group="Behavior"
			Type="String"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
