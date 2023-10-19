echo "*****************************************************"
echo "STARTING SEEDING SCRIPT FOR MYSQL DATABASE!"
echo "*****************************************************"

echo "Installing required modules"
pip install -r requirements.txt

echo "Waiting For DB to Start"
python SEED00-wait.py

echo "Seeding File Table"
python SEED01-File.py

echo "Seeding User Table"
python SEED02-User.py

echo "*****************************************************"
echo "FINISH SEEDING!"
echo "*****************************************************"