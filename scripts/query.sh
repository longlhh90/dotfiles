# Initialize an empty array to hold the headers
HEADERS=("Content-Type: application/json")

# Parse the command-line arguments
while [[ $# -gt 0 ]]
do
    key="$1"

    case $key in
        -e|--endpoint)
        API_ENDPOINT="$2"
        shift # past argument
        shift # past value
        ;;
        -q|--query-params)
        QUERY_PARAMS="$2"
        shift # past argument
        shift # past value
        ;;
        -b|--body)
        BODY="$2"
        shift # past argument
        shift # past value
        ;;
        -h|--header)
        HEADERS+=("$2")
        shift # past argument
        shift # past value
        ;;
        *)    # unknown option
        echo "Unknown option: $1"
        exit 1
        ;;
    esac
done

# Check if the curl command is available
if ! command -v curl &> /dev/null
then
    echo "curl command not found. Please install curl and try again."
    exit 1
fi

# Call the curl command with the specified options
curl -X GET \
     -H "${HEADERS[@]}" \
     -d "${BODY}" \
     "${API_ENDPOINT}?${QUERY_PARAMS}" \
     -sS | jq .
