defprotocol ProtocolExploration.Dimensions do
    @spec height(t()) :: integer()
    def height(value)

    @spec width(t()) :: integer()
    def width(value)
end