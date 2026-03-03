package entralinked;

import java.util.Collection;
import java.util.List;

public record CommandLineArguments(boolean disableGui, String dnsAddress) {
    
    public CommandLineArguments(Collection<String> args) {
        this(args.contains("disablegui"), extractDnsAddress(args));
    }
    
    public CommandLineArguments(String... args) {
        this(List.of(args));
    }
    
    private static String extractDnsAddress(Collection<String> args) {
        List<String> argsList = new java.util.ArrayList<>(args);
        for(int i = 0; i < argsList.size(); i++) {
            if(argsList.get(i).equals("--dns") && i + 1 < argsList.size()) {
                return argsList.get(i + 1);
            }
        }
        return null;
    }
}
