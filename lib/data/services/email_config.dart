class EmailConfig {
  // Email configuration constants
  static const String smtpHost = 'smtp.gmail.com';
  static const int smtpPort = 587;

  // You need to set these environment variables or replace with your actual credentials
  // For Gmail, you need to use App Passwords instead of your regular password
  static const String senderEmail =
      'bukizzstore@gmail.com'; // Replace with your email
  static const String senderPassword =
      'vfdo ulef irig fzzj'; // Replace with your app password
  static const String senderName = 'Bukizz Support';

  // Email templates
  static String getOTPEmailTemplate(String otp, int validityMinutes) {
    return '''
    <div style="font-family: Arial, sans-serif; max-width: 600px; margin: 0 auto; padding: 20px;">
      <div style="text-align: center; margin-bottom: 30px;">
        <h1 style="color: #2196F3; margin-bottom: 10px;">Bukizz</h1>
        <h2 style="color: #333; margin: 0;">Email Verification</h2>
      </div>
      
      <div style="background-color: #f8f9fa; padding: 30px; border-radius: 10px; margin: 20px 0;">
        <p style="font-size: 16px; color: #333; margin-bottom: 20px;">Hello,</p>
        <p style="font-size: 16px; color: #333; margin-bottom: 20px;">Your verification code is:</p>
        
        <div style="background-color: #fff; border: 2px dashed #2196F3; padding: 20px; text-align: center; margin: 20px 0; border-radius: 8px;">
          <h1 style="color: #2196F3; font-size: 36px; letter-spacing: 8px; margin: 0; font-family: 'Courier New', monospace;">$otp</h1>
        </div>
        
        <p style="font-size: 14px; color: #666; text-align: center; margin: 20px 0;">
          This code will expire in <strong>$validityMinutes minutes</strong>
        </p>
        
        <div style="border-top: 1px solid #ddd; padding-top: 20px; margin-top: 30px;">
          <p style="font-size: 14px; color: #666; margin-bottom: 10px;">
            If you didn't request this verification, please ignore this email.
          </p>
          <p style="font-size: 14px; color: #666; margin: 0;">
            For security reasons, never share this code with anyone.
          </p>
        </div>
      </div>
      
      <div style="text-align: center; margin-top: 30px; padding-top: 20px; border-top: 1px solid #ddd;">
        <p style="font-size: 14px; color: #888; margin: 0;">
          Best regards,<br>
          <strong style="color: #2196F3;">The Bukizz Team</strong>
        </p>
      </div>
    </div>
    ''';
  }

  // Alternative email services configuration
  static const Map<String, Map<String, dynamic>> alternativeServices = {
    'sendgrid': {
      'api_key': 'your-sendgrid-api-key',
      'from_email': 'noreply@yourdomain.com',
      'from_name': 'Bukizz App'
    },
    'aws_ses': {
      'region': 'us-east-1',
      'access_key': 'your-aws-access-key',
      'secret_key': 'your-aws-secret-key',
      'from_email': 'noreply@yourdomain.com'
    }
  };
}
