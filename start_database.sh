echo "*****************************************************"
echo "SETTING UP DATABASE DOCKER CONTAINER"
echo "*****************************************************"

chmod -R 777 *

# Set unix file delimiters
sed -i -e 's/^M$//' ./start_database.sh
sed -i -e 's/\r$//' ./init/mysql-seed/seed.sh


# Load environment variables from .env file
if [ -f .env ]; then
    export $(cat .env | grep -v '#' | awk '/=/ {print $1}')
fi

# Stop and remove existing containers
docker-compose down

docker-compose build

# Start the containers in detached mode and follow the logs
docker-compose up --detach --remove-orphans

# Wait for the containers to be up and running
until mysqladmin ping -h 127.0.0.1 -P 3323 -u root --password="$MYSQL_ROOT_PASSWORD" --silent; do
    echo "Waiting for MySQL to start..."
    sleep 1
done

echo "*****************************************************"
echo "TABLES CREATED:"
echo "*****************************************************"
# Check Tables Created!
mysql -h 127.0.0.1 -P 3323 -u root --password="$MYSQL_ROOT_PASSWORD" -e "SHOW TABLES;" SITRecipe

until ! docker ps --quiet --filter "name=ict3x03-team7-database-mysql-seed-1" | grep -q "ict3x03-team7-database-mysql-seed-1"; do
    echo "*****************************************************"
    echo "SEEDING DATABASE DOCKER CONTAINER!"
    echo "*****************************************************"
    sleep 1
done

echo "*****************************************************"
echo "DATABASE DOCKER CONTAINER SEEDED!"
echo "*****************************************************"