#tag Class
Protected Class App
Inherits WebApplication
	#tag Event
		Function HandleURL(Request As WebRequest, Response As WebResponse) As Boolean
		  Var cal As New iCal.Calendar
		  
		  cal.Name = "My Calendar"
		  cal.Description = "Corporate Event Calendar for ABC Tools"
		  
		  Var now As DateTime = DateTime.Now
		  
		  Var startDate As New DateTime(now.Year, now.Month, now.Day+1, 9, 0, 0) // 9 AM Tomorrow
		  
		  Var meetingLength As New DateInterval(0, 0, 0, 1) // 1 hour
		  Var endDate As DateTime = startDate + meetingLength
		  
		  // If you don't provide a UID, the class will create one for you
		  // which you must use again if you want to make changes
		  cal.AddEvent("Meeting", startDate, endDate, "CalendarTag") 
		  
		  Response.Header("Content-Type") = "text/calendar"
		  Response.Header("Content-Disposition") = "attachment; filename=""" + cal.Name + ".ics"
		  Response.Write cal.Render
		  Response.Status = 200
		  Return True
		End Function
	#tag EndEvent


	#tag ViewBehavior
	#tag EndViewBehavior
End Class
#tag EndClass
