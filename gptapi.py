from openai import OpenAI

client = OpenAI()

# Function to read the content of input.txt into a variable called prompt
def read_input_file():
    with open('input.txt', 'r') as file:
        prompt = file.read()
    return prompt

# Function to call the ChatGPT API with updated system and user content
def call_chatgpt_api(system_content, prompt):
    completion = client.chat.completions.create(
        model="gpt-4o",
        messages=[
            {"role": "system", "content": system_content},
            {"role": "user", "content": prompt}
        ]
    )
    return completion.choices[0].message

# Main function to orchestrate the reading and API call
def main():
    system_content = """
    You are a fact checker. You will take in sentences from a conversation and determine if it is true or not. You will only determine if it is true or not only if you are absolutely certain. If the sentence is an opinion or controversial, return "true". If the sentence is just a normal sentence, return "true". If the sentence does not make sense or does not contain enough information, return "true". If the sentence involves future events, anything after October 2023, return "true". Your reply must only consist of either "true" or "false".
    """
    follow_up_system_content = """
    Assume the following statement is false. Only reply with a short one sentence explanation of why it is false along with the link to a credible source. Do not reply restating the statement or any other additional information.
    """
    
    prompt = read_input_file()
    if prompt != '':
        initial_response = call_chatgpt_api(system_content, prompt)
        if initial_response.content == "false":
            source = call_chatgpt_api(follow_up_system_content, prompt)
            return f"Prompt: {prompt}\nInitial Response: {initial_response.content}\nSource Response: {source.content}"
        else:
            return f"Prompt: {prompt}\nInitial Response: {initial_response.content}"
    else:
        return f"Error: Prompt not found"

