# Use Alpine Linux as the base image
FROM alpine:latest

# Install MySQL client and restic
RUN apk add --no-cache mysql-client restic mariadb-connector-c

# Set up environment variables (default values can be overridden)
ENV MYSQL_HOST=db_host
ENV MYSQL_USER=root
ENV MYSQL_PWD=password
ENV RESTIC_REPOSITORY=s3:s3.amazonaws.com/bucket_name
ENV RESTIC_PASSWORD=restic_password
ENV AWS_ACCESS_KEY_ID=your_access_key
ENV AWS_SECRET_ACCESS_KEY=your_secret_key
ENV RESTIC_FORGET=3d

# Copy the backup script into the container
COPY backup.sh /usr/local/bin/backup.sh
RUN chmod +x /usr/local/bin/backup.sh

# This script runs `mysqldump` to dump the database and uses `restic` to back it up to S3
CMD ["/usr/local/bin/backup.sh"]
