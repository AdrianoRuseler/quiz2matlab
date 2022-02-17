import xml.etree.cElementTree as ET

worksheet = ET.Element("worksheet", xmlns="http://smath.info/schemas/worksheet/1.0")
worksheet.append(ET.Comment('This is a comment'))

# 
# settings field
settings = ET.SubElement(worksheet, "settings", ppi="96") # settings fields

# identity
identity=ET.SubElement(settings, "identity")
ET.SubElement(identity, "id").text = "d97ab239-e42d-4691-b1d4-876a97385221" #  d97ab239-e42d-4691-b1d4-876a97385221
ET.SubElement(identity, "revision").text = "2" #  

# calculation field
calculation=ET.SubElement(settings, "calculation")
ET.SubElement(calculation,"precision").text = '4' #  
ET.SubElement(calculation,"exponentialThreshold").text = '5' #  
ET.SubElement(calculation,"trailingZeros").text = 'false' #  
ET.SubElement(calculation,"significantDigitsMode").text = 'false' #  
ET.SubElement(calculation,"roundingMode").text = '0' #  
ET.SubElement(calculation,"fractions").text = 'decimal' #  

 # pageModel field
pageModel=ET.SubElement(settings, "pageModel", active="false", viewMode="2", printGrid="false", printAreas="true", simpleEqualsOnly="false", printBackgroundImages="true")
paper=ET.SubElement(pageModel, "paper", id="9", orientation="Portrait", width="827", height="1169")
margins=ET.SubElement(pageModel, "margins", left="39", right="39", top="49", bottom="49")     
header=ET.SubElement(pageModel, "header", alignment="Center", color="#a9a9a9").text = '&amp;[DATE] &amp;[TIME] - &amp;[FILENAME]' #
footer=ET.SubElement(pageModel, "footer", alignment="Center", color="#a9a9a9").text = '&amp;[PAGENUM] / &amp;[COUNT]' #
backgrounds=ET.SubElement(pageModel, "backgrounds")       
                
# dependencies field
dependencies=ET.SubElement(settings, "dependencies")     
ET.SubElement(dependencies, "assembly", name="SMath Studio Desktop", version="0.99.7822.147", guid="a37cba83-b69c-4c71-9992-55ff666763bd")            
ET.SubElement(dependencies, "assembly", name="MathRegion", version="1.11.7822.147", guid="02f1ab51-215b-466e-a74d-5d8b1cf85e8d")                 
                

# <regions type="content">
regions = ET.SubElement(worksheet, "regions", type="content") # regions fields
region=ET.SubElement(regions, "region", left="50", top="18", width="73", height="30", color="#000000", fontSize="10")
math=ET.SubElement(region, "math")
mathinput=ET.SubElement(math, "input")
ET.SubElement(mathinput, "e",type="operand").text = 'X.Y' # 
ET.SubElement(mathinput, "e",type="operand").text = '15' # 
ET.SubElement(mathinput, "e",type="operand",style="unit").text = 'A' # 
ET.SubElement(mathinput, "e",type="operator",args="2").text = '*' # 
ET.SubElement(mathinput, "e",type="operator",args="2").text = ':' # 


region=ET.SubElement(regions, "region", left="150", top="18", width="73", height="30", color="#000000", fontSize="10")
math=ET.SubElement(region, "math")
mathinput=ET.SubElement(math, "input")
ET.SubElement(mathinput, "e",type="operand").text = 'Y.X' # 
ET.SubElement(mathinput, "e",type="operand").text = '45' # 
ET.SubElement(mathinput, "e",type="operand",style="unit").text = 'V' # 
ET.SubElement(mathinput, "e",type="operator",args="2").text = '*' # 
ET.SubElement(mathinput, "e",type="operator",args="2").text = ':' # 


tree = ET.ElementTree(worksheet)
ET.indent(tree)
tree.write("teste.sm",xml_declaration=True, encoding="utf-8",short_empty_elements=True) # Enabled self-closed tag


#SMathXML='teste.sm'
#out = open(SMathXML, 'wb')
#out.write(b'<?xml version="1.0" encoding="UTF-8" standalone = "yes"?>\n')
#out.write(b'<?application progid="SMath Studio Desktop" version="0.99.7822.147"?>')
#tree.write(out, xml_declaration=True, encoding="utf-8",short_empty_elements=True)
#out.close()

