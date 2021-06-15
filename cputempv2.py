##############||CPUTemp auslesen und in Variable speichern||##############

with open('/sys/class/thermal/thermal_zone0/temp', 'r') as f:
    temp = f.read()
    temp = float(temp) / 1000
    temp = round(temp, 2)
    print(temp)

#########################################################################

data = []

with open('/var/www/html/index.html', 'r') as file:
    for line in file:
        data.append(line)
#print(data)

for i, line in enumerate(data):
    if "CPUTemp =" in line:
        data[i] = "CPUTemp = " + str(temp) + "\n"

data = ''.join(data)
with open('/var/www/html/index.html', 'w') as file:
    file.write(data)


