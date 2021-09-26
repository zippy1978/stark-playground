import json

extern sleep(d: int)

func main(): int {
    
    //while (true) {
        
        
        //result := json.parse("{ \"key1\" : \"value1\"}")
        //yo := "test" + "you"
        
        //sleep(1)
    //}

     jsonString := 
    "
        {
        \"quiz\": {
            \"sport\": {
                \"q1\": {
                    \"question\": \"Which one is correct team name in NBA?\",
                    \"options\": [
                        \"New York Bulls\",
                        \"Los Angeles Kings\",
                        \"Golden State Warriros\",
                        \"Huston Rocket\"
                    ],
                    \"answer\": \"Huston Rocket\"
                }
            },
            \"maths\": {
                \"q1\": {
                    \"question\": \"5 + 7 = ?\",
                    \"options\": [
                        \"10\",
                        \"11\",
                        \"12\",
                        \"13\"
                    ],
                    \"answer\": \"12\"
                },
                \"q2\": {
                    \"question\": \"12 - 8 = ?\",
                    \"options\": [
                        \"1\",
                        \"2\",
                        \"3\",
                        \"4\"
                    ],
                    \"answer\": \"4\"
                }
            }
        }
    }
    "

    result := json.parse(jsonString)
    if (result.error != null) {
        println("error : " + result.error)
        return -1
    }

    return 0
    
}