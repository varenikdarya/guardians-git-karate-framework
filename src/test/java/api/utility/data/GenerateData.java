package api.utility.data;

public class GenerateData {
	
	
	public static String getEmail() {
		String prefix = "instructor_email";
		String provider = "@tekschool.us";		
		int random = (int) (Math.random() * 10000);
		String email = prefix + random + provider; 
		return email;
	}
	
	/**
     * Generate Random Phone number 10 digit
     * @return String random phone number
     * If you can improve it to better solution do it 
     * 20 Minute break
     */
    public static String getPhoneNumber() {
        String phoneNumber = "2";
        for (int i = 0; i < 9 ; i ++) {
            phoneNumber += (int) (Math.random() * 10);
        }
        return phoneNumber;
    
		
		
	}
}