#tag Class
Protected Class CalendarEvent
	#tag Method, Flags = &h0
		Sub Constructor(Summary as String, StartDate as DateTime, EndDate as DateTime, UID as String = "")
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
		Private Function ConvertDate(d as DateTime, includeTime as Boolean = True) As String
		  Var sa() As String
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
		  
		  Var sa() As String
		  
		  Var now As DateTime = DateTime.Now
		  
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
		    Var ex As New UnsupportedOperationException
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
		EndDate As DateTime
	#tag EndComputedProperty

	#tag Property, Flags = &h0
		Location As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mDuration As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mEndDate As DateTime
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mUID As String
	#tag EndProperty

	#tag Property, Flags = &h0
		StartDate As DateTime
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
			Name="Summary"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="UID"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Busy"
			Visible=false
			Group="Behavior"
			InitialValue="False"
			Type="Boolean"
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
			Name="DurationMinutes"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Location"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Status"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Statuses"
			EditorType="Enum"
			#tag EnumValues
				"0 - Unknown"
				"1 - Confirmed"
				"2 - Tentative"
				"3 - Cancelled"
			#tag EndEnumValues
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
