# Security Configuration

## Admin User Setup

### Environment Variables
Create a `.env` file in the root directory with:

```bash
ADMIN_EMAIL=your_admin_email@thailandeigentum.de
ADMIN_PASSWORD=your_very_secure_password_here
```

### Password Requirements
- Minimum 12 characters
- Include uppercase, lowercase, numbers, and symbols
- Avoid dictionary words
- Use a password manager

### Production Deployment
**NEVER** commit `.env` files to version control. Set environment variables on your production server:

```bash
# Example for most hosting services
export ADMIN_EMAIL="admin@thailandeigentum.de"
export ADMIN_PASSWORD="your_secure_password"
```

## Database Security
1. **Seeds**: Run `rails db:seed` to create admin user with secure credentials
2. **Password**: Admin password will be auto-generated if not set via ENV
3. **Access**: Only admin users can access `/admin` routes

## Security Best Practices
- [ ] Change default admin credentials after first login
- [ ] Use HTTPS in production
- [ ] Keep Rails and gems updated
- [ ] Regular security audits with `bundle audit`
- [ ] Monitor login attempts
- [ ] Use strong database passwords

## Current Security Features
- ✅ Devise authentication with encrypted passwords
- ✅ Admin role-based access control
- ✅ CSRF protection
- ✅ SQL injection protection (ActiveRecord)
- ✅ XSS protection (Rails escaping)
- ✅ Environment-based credential management

## Security Checklist for Production
- [ ] Set strong ADMIN_PASSWORD environment variable
- [ ] Configure HTTPS/SSL
- [ ] Set up database backups
- [ ] Enable application monitoring
- [ ] Configure proper file permissions
- [ ] Set up firewall rules