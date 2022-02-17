import base64

encoded = base64.b64encode(open("diode00.png", "rb").read()).decode('ascii')

print(format(encoded))