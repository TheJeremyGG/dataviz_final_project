# Data Visualization 

> Jeremy Gerardi

## Mini-Project 1

This project explores the global trends in cybersecurity threats between 2015 and 2024, leveraging R for data visualization. 
The goal is to identify and present key insights on financial losses, types of cyber attacks, and common security vulnerabilities through clear and effective charts.

### Summary of findings:

- Financial losses from cyber attacks have fluctuated over the past decade.
- Certain types of attacks such as DDoS and phishing are more common than others, suggesting that those areas should become high priorities in terms of increasing defense mechanisms.
- Zero-day, social engineering, unpatched software, and weak passwords are almost equally exploited, showing that they should all be thought of as high risk when considering vulnerabilities.

### Description of data:

- The dataset includes the following columns:
    - Country
        - Australia
        - Brazil
        - China
        - France
        - Germany
        - India
        - Japan
        - Russia
        - UK
        - US
    - Year
        - 2015-2024
    - Attack Type
        - DDoS
        - Malware
        - Man-in-the-Middle
        - Phisihing
        - Ransomware
        - SQL Injection
    - Target Industry
        - Banking
        - Education
        - Government
        - Healthcare
        - IT
        - Retail
        - Telecommunications
    - Financial Loss (in Million $)
    - Number of Affected Users
    - Attack Source
        - Hacker Group
        - Insider
        - Nation State
        - Unknown
    - Security Vulnerability Type
        - Social Engineering
        - Unpatched Software
        - Weak Passwords
        - Zero-day
    - Defense Mechanism Used
        - AI-based Detection
        - Antivirus
        - Encryption
        - Firewall
        - VPN
    - Incident Resolution Time (in Hours)


## Mini-Project 2

This project analyzes birth trends in the United States from 2000 to 2014using R for data visualizaton.
The goal is to explore different aspects of birth data, such as how birth counts change over time and how they can be visualized interactively.

### Summary of findings:
- Weekends have significantly fewer births than weekdays. A possible explanation for this could be fewer scheduled medical procedures required.
- There is a gradual downward trend in total monthly births across the 15 year period in the dataset

### Description of data:
- The dataset includes the following columns:
  - Year 
    - 2000 - 2014
  - Month 
    - 1 - 12
  - date_of_month 
    - 1 - 31
  - date 
    - 1/1/2000 - 12/31/2014
  - day_of_week 
    - Sat
    - Sun
    - Mon
    - Tues
    - Wed
    - Thurs
    - Fri
  - births