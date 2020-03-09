#tag Class
Protected Class App
Inherits WebApplication
	#tag Event
		Function HandleSpecialURL(Request As WebRequest) As Boolean
		  Dim cal As New iCal.Calendar
		  
		  cal.Name = "My Calendar"
		  cal.Description = "Corporate Event Calendar for ABC Tools"
		  
		  Dim d As DateTime =  DateTime.Now
		  
		  Dim enddate As DateTime = DateTime.Now
		  enddate = Enddate.AddInterval(0,0,0,2)
		  
		  
		  // If you don't provide a UID, the class will create one for you
		  // which you must use again if you want to make changes
		  cal.AddEvent("Meeting", d, endDate, "CalendarTag") 
		  
		  Dim d2 As DateTime =  DateTime.Now
		  d2 = d2.AddInterval(0,0,2)
		  Dim enddate2 As DateTime = d2.AddInterval(0,0,0,2)
		  
		  // If you don't provide a UID, the class will create one for you
		  // which you must use again if you want to make changes
		  cal.AddEvent("Meeting2", d2, endDate2, "CalendarTag2") 
		  
		  Dim d3 As DateTime =  DateTime.Now
		  d3 = d3.AddInterval(0,0,3)
		  
		  Dim enddate3 As DateTime = d3.AddInterval(0,0,0,2)
		  
		  
		  Dim testEvent As New iCal.CalendarEvent("Meeting3", d3, Enddate3, "CalendarTag3")
		  testEvent.Description = "Long Description"
		  testEvent.Status = iCal.CalendarEvent.Statuses.Confirmed
		  testEvent.Location = "New York"
		  testEvent.Categories.Append("Meeting")
		  
		  cal.AddEvent(testEvent)
		  
		  Dim d4 As Datetime = DateTime.Now
		  d4 = d4.AddInterval(0,0,4)
		  
		  Dim enddate4 As New datetime(d4)
		  
		  Dim allDayEvent As New iCal.CalendarEvent("AllDay Meeting",d4, Enddate4, "CalendarTag4")
		  allDayEvent.AllDay = True
		  cal.AddEvent(allDayEvent)
		  
		  Dim d5 As DateTime = DateTime.now
		  d5 = d5.AddInterval(0,0,5)
		  Dim enddate5 As Datetime = d5.AddInterval(0,0,2)
		  
		  Dim multiDayEvent As New iCal.CalendarEvent("3 Day Party",d5, enddate5, "CalendarTag5")
		  multiDayEvent.AllDay = True
		  cal.AddEvent(multiDayEvent)
		  
		  request.Header("Content-Type") = "text/calendar"
		  //request.Header("Content-Disposition") = "attachment; filename=""" + cal.Name + ".ics"
		  Request.Print cal.Render
		  request.Status = 200
		  Return True
		End Function
	#tag EndEvent


	#tag ViewBehavior
	#tag EndViewBehavior
End Class
#tag EndClass
