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
		  If trim(Description) <> "" Then
		    sa.Append "DESCRIPTION:" + Description
		  End If
		  sa.Append "UID:" + UID
		  sa.Append "DTSTAMP:" + ConvertDate(now, True)
		  sa.Append "DTSTART;VALUE=DATE:" + ConvertDate(StartDate)
		  If EndDate <> Nil Then
		    sa.Append "DTEND;VALUE=DATE:" + ConvertDate(EndDate)
		  ElseIf mDuration > 0 Then
		    sa.Append "DURATION:PT" + Str(DurationMinutes, "0") + "M"
		  Else
		    Dim ex As New UnsupportedOperationException
		    ex.Message = "You must either specify an end date or a duration!"
		    Raise ex
		  End If
		  If UBound(Categories) > -1 Then
		    sa.Append "CATEGORIES:" + Uppercase(join(Categories, ","))
		  End If
		  If Not Busy Then
		    sa.Append "TRANSP:TRANSPARENT"
		  End If
		  If trim(location) <> "" Then
		    sa.Append "LOCATION:" + Location
		  End If
		  
		  Select Case status
		  Case Statuses.Cancelled
		    sa.Append ("STATUS:CANCELLED")
		  Case Statuses.Confirmed
		    sa.Append ("STATUS:CONFIRMED")
		  Case Statuses.Tentative
		    sa.Append ("STATUS:TENTATIVE")
		  End Select
		  
		  sa.Append "END:VEVENT"
		  
		  return join(sa,EndOfLine)
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0
		Busy As Boolean = False
	#tag EndProperty

	#tag Property, Flags = &h0
		Categories() As String
	#tag EndProperty

	#tag Property, Flags = &h0
		Description As String
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return mDuration
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mDuration = value
			  mEndDate = nil
			End Set
		#tag EndSetter
		DurationMinutes As Integer
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return mEndDate
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mEndDate = value
			  mDuration = 0
			End Set
		#tag EndSetter
		EndDate As Date
	#tag EndComputedProperty

	#tag Property, Flags = &h0
		Location As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mDuration As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mEndDate As Date
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mUID As String
	#tag EndProperty

	#tag Property, Flags = &h0
		StartDate As Date
	#tag EndProperty

	#tag Property, Flags = &h0
		Status As Statuses
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


	#tag Enum, Name = Statuses, Type = Integer, Flags = &h0
		Unknown
		  Confirmed
		  Tentative
		Cancelled
	#tag EndEnum


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
			EditorType="MultiLineEditor"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
