#tag Class
Protected Class App
Inherits WebApplication
	#tag Event
		Function HandleSpecialURL(Request As WebRequest) As Boolean
		  Dim cal As New iCal.Calendar
		  
		  cal.Name = "My Calendar"
		  cal.Description = "Corporate Event Calendar for ABC Tools"
		  
		  Dim d As New Date
		  d.Day = d.Day + 1 // tomorrow
		  d.Hour = 9 // 9AM
		  d.Minute = 0
		  d.Second = 0
		  
		  Dim endDate As New Date
		  endDate.Day = endDate.Day + 1
		  d.Hour = 10
		  d.Minute = 0
		  d.Second = 0
		  
		  // If you don't provide a UID, the class will create one for you
		  // which you must use again if you want to make changes
		  cal.AddEvent("Meeting", d, endDate, "CalendarTag") 
		  
		  request.Header("Content-Type") = "text/calendar"
		  request.Header("Content-Disposition") = "attachment; filename=""" + cal.Name + ".ics"
		  Request.Print cal.Render
		  request.Status = 200
		  Return True
		End Function
	#tag EndEvent


	#tag ViewBehavior
	#tag EndViewBehavior
End Class
#tag EndClass
